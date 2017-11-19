package systems;

import kha.Color;
import kha.Shaders;
import kha.Image;
import kha.graphics4.PipelineState;
import kha.graphics4.VertexStructure;
import kha.graphics4.VertexData;
import kha.graphics4.ConstantLocation;
import kha.graphics4.TextureUnit;
import kha.graphics4.CullMode;
import kha.graphics4.CompareMode;
import edge.ISystem;
import edge.View;
import components.Camera;
import components.MeshRender;
import components.Transform;
import components.LightDirection;
import components.LightAmbient;
import components.SunShadow;
import components.LightDarken;
import types.Mesh;
using glm.Mat4;
using glm.Vec4;
using glm.Vec3;

class Render implements ISystem {
    var renderables:View<{t:Transform, mr:MeshRender}>;
    var directionalLights:View<{l:LightDirection}>;
    var ambientLights:View<{l:LightAmbient}>;
    var sunShadows:View<{ss:SunShadow}>;
    var lightDarkens:View<{ld:LightDarken}>;

	var standardPipeline:PipelineState;
	var mvpID:ConstantLocation;
	var mID:ConstantLocation;
    var lightDirectionID:ConstantLocation;
    var lightColourID:ConstantLocation;
    var ambientColourID:ConstantLocation;
    var texID:TextureUnit;
    var shadowMVPID:ConstantLocation;
    var shadowMapID:TextureUnit;
    var shadowBiasID:ConstantLocation;
    var boundaryColourID:ConstantLocation;

    var bg:Color = Color.fromBytes(41, 173, 255);
    var mvp:Mat4;
    var lightDirection:Vec3;
    var lightColour:Vec3;
    var ambientColour:Vec3;
    var shadowBias:Float = 0.0005;

    public function new() {
        // initialize everything!
        mvp = new Mat4();
        lightDirection = new Vec3(0, 1, 0);
        lightColour = new Vec3(1, 1, 1);
        ambientColour = new Vec3(0, 0, 0);

        var structure = new VertexStructure();
        structure.add("position", VertexData.Float3);
        structure.add("normal",   VertexData.Float3);
        structure.add("texcoord", VertexData.Float2);

		standardPipeline = new PipelineState();
		standardPipeline.inputLayout = [structure];
		standardPipeline.vertexShader = Shaders.standard_vert;
		standardPipeline.fragmentShader = Shaders.standard_frag;
        standardPipeline.cullMode = CullMode.Clockwise;
        standardPipeline.depthMode = CompareMode.Less;
        standardPipeline.depthWrite = true;

        try {
            standardPipeline.compile();
        }
        catch(e:String) {
            #if js
            js.Browser.console.error(e);
            #else
            trace('ERROR:');
            trace(e);
            #end
        }

		mvpID = standardPipeline.getConstantLocation("MVP");
		mID = standardPipeline.getConstantLocation("M");
		lightDirectionID = standardPipeline.getConstantLocation("lightDirection");
		lightColourID = standardPipeline.getConstantLocation("lightColour");
		ambientColourID = standardPipeline.getConstantLocation("ambientColour");
		texID = standardPipeline.getTextureUnit("tex");
		shadowMVPID = standardPipeline.getConstantLocation("shadowMVP");
		shadowMapID = standardPipeline.getTextureUnit("shadowMap");
		shadowBiasID = standardPipeline.getConstantLocation("shadowBias");
		boundaryColourID = standardPipeline.getConstantLocation("boundaryColour");
    }

    function update(cam:Camera, t:Transform) {
        var lightScale:Float = 1;
        for(d in lightDarkens) {
            if(d.data.ld.lightScale < lightScale) {
                lightScale = d.data.ld.lightScale;
            }
        }
        var clearColour:Color = Color.fromFloats(bg.R * lightScale, bg.G * lightScale, bg.B * lightScale, 1);

        //var g = Game.state.g4;
        var g = cam.renderBuffer.g4;
        g.begin();
        g.clear(clearColour, 1);
        g.setPipeline(standardPipeline);

        g.setFloat3(boundaryColourID, bg.R * lightScale, bg.G * lightScale, bg.B * lightScale);

        // lights!
        for(light in directionalLights) {
            light.data.l.direction.copy(lightDirection);
            light.data.l.colour.copy(lightColour);
        }
        for(light in ambientLights) {
            light.data.l.colour.copy(ambientColour);
        }
        lightColour.multiplyScalar(lightScale, lightColour);
        ambientColour.multiplyScalar(lightScale, ambientColour);
        g.setVector3(lightDirectionID, lightDirection);
        g.setVector3(lightColourID, lightColour);
        g.setVector3(ambientColourID, ambientColour);

        // shadows
        var shadowMap:Image = null;
        for(ss in sunShadows) {
            shadowMap = ss.data.ss.image;
        }
        g.setFloat(shadowBiasID, shadowBias);

        for(target in renderables) {
            var rt:Transform = target.data.t;
            var rmr:MeshRender = target.data.mr;

            mvp = Mat4.multMat(cam.vp, rt.m, mvp);
            if(shouldCull(mvp, rmr.mesh)) {
                continue;
            }

            g.setMatrix(mvpID, mvp);
            g.setMatrix(mID, rt.m);
            g.setMatrix(shadowMVPID, rmr.shadowMVP);
            g.setTexture(texID, rmr.texture);
            g.setTexture(shadowMapID, shadowMap);

            g.setVertexBuffer(rmr.mesh.vertexBuffer);
            g.setIndexBuffer(rmr.mesh.indexBuffer);
            g.drawIndexedVertices();
        }
    }

    private inline function isInPlane(a:Float, b:Float, c:Float, d:Float, mesh:Mesh):Bool {
        // calculate p-vertex // see http://www.txutxi.com/?p=584
        var px:Float = a > 0 ? mesh.max.x : mesh.min.x;
        var py:Float = b > 0 ? mesh.max.y : mesh.min.y;
        var pz:Float = c > 0 ? mesh.max.z : mesh.min.z;
        // if ax + by + cz + d > 0, we're on the *in* side!
        return (a * px) + (b * py) + (c * pz) + d >= 0;
    }

    private function shouldCull(mvp:Mat4, mesh:Mesh):Bool {
        // order can maybe be changed here to ditch early for things that are more likely
        // but this gets messed up by the transformation, since this is happening
        // in the object space rather than any global space

        // near
        if(!isInPlane(mvp.r3c0 + mvp.r2c0, mvp.r3c1 + mvp.r2c1, mvp.r3c2 + mvp.r2c2, mvp.r3c3 + mvp.r2c3, mesh))
            return true;
        // far
        if(!isInPlane(mvp.r3c0 - mvp.r2c0, mvp.r3c1 - mvp.r2c1, mvp.r3c2 - mvp.r2c2, mvp.r3c3 - mvp.r2c3, mesh))
            return true;
        // left
        if(!isInPlane(mvp.r3c0 + mvp.r0c0, mvp.r3c1 + mvp.r0c1, mvp.r3c2 + mvp.r0c2, mvp.r3c3 + mvp.r0c3, mesh))
            return true;
        // right
        if(!isInPlane(mvp.r3c0 - mvp.r0c0, mvp.r3c1 - mvp.r0c1, mvp.r3c2 - mvp.r0c2, mvp.r3c3 - mvp.r0c3, mesh))
            return true;
        // top
        if(!isInPlane(mvp.r3c0 - mvp.r1c0, mvp.r3c1 - mvp.r1c1, mvp.r3c2 - mvp.r1c2, mvp.r3c3 - mvp.r1c3, mesh))
            return true;
        // bottom
        if(!isInPlane(mvp.r3c0 + mvp.r1c0, mvp.r3c1 + mvp.r1c1, mvp.r3c2 + mvp.r1c2, mvp.r3c3 + mvp.r1c3, mesh))
            return true;

        return false;
    }
}
