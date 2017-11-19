package systems;

import kha.Color;
import kha.Shaders;
import kha.Image;
import kha.System;
import kha.graphics4.PipelineState;
import kha.graphics4.VertexStructure;
import kha.graphics4.VertexBuffer;
import kha.graphics4.IndexBuffer;
import kha.graphics4.VertexData;
import kha.graphics4.Usage;
import kha.graphics4.ConstantLocation;
import kha.graphics4.TextureUnit;
import kha.graphics4.CullMode;
import kha.graphics4.CompareMode;
import edge.ISystem;
import edge.View;
import components.Camera;
import components.SnapCamera;
import components.Shot;
import types.Mesh;
using glm.Mat4;
using glm.Vec4;
using glm.Vec3;

class RenderPostProcessing implements ISystem {
    var shots:View<{shot:Shot}>;

	var postPipeline:PipelineState;
    public var vertexBuffer(default, null):VertexBuffer;
	public var indexBuffer(default, null):IndexBuffer;
    var resolutionID:ConstantLocation;
    var paramsID:ConstantLocation;
    var texID:TextureUnit;
    var bg:Color = Color.Magenta;

    public function new() {
        var structure = new VertexStructure();
        structure.add("position", VertexData.Float2);

		postPipeline = new PipelineState();
		postPipeline.inputLayout = [structure];
		postPipeline.vertexShader = Shaders.post_vert;
		postPipeline.fragmentShader = Shaders.post_frag;
        postPipeline.cullMode = CullMode.CounterClockwise;
        postPipeline.depthMode = CompareMode.Always;
        postPipeline.depthWrite = false;

        try {
            postPipeline.compile();
        }
        catch(e:String) {
            #if js
            js.Browser.console.error(e);
            #else
            trace('ERROR:');
            trace(e);
            #end
        }

		resolutionID = postPipeline.getConstantLocation("resolution");
		paramsID = postPipeline.getConstantLocation("params");
		texID = postPipeline.getTextureUnit("tex");

        var vertices:Array<Float> = [
            -1, -1,
            -1, 1,
            1, 1,
            1, -1
        ];
        var indices:Array<Int> = [
            0, 1, 2,
            2, 3, 0
        ];

        vertexBuffer = new VertexBuffer(4, structure, Usage.StaticUsage);
        var vbData = vertexBuffer.lock();
        for(v in 0...4) {
            vbData[(v * 2) + 0] = vertices[(v * 2) + 0];
            vbData[(v * 2) + 1] = vertices[(v * 2) + 1];
        }
        vertexBuffer.unlock();

		indexBuffer = new IndexBuffer(indices.length, Usage.StaticUsage);
		var iData = indexBuffer.lock();
		for (i in 0...iData.length) {
			iData[i] = indices[i];
		}
		indexBuffer.unlock();
    }

    function update(cam:Camera, s:SnapCamera) {
        var g = Game.state.g4;
        g.begin();
        g.clear(bg, 1);
        g.setPipeline(postPipeline);
        
        g.setFloat4(paramsID, s.flash, s.transition, 0, 0);
        g.setFloat2(resolutionID, Game.state.w, Game.state.h);
        g.setTexture(texID, cam.renderBuffer);

        g.setVertexBuffer(vertexBuffer);
        g.setIndexBuffer(indexBuffer);
        g.drawIndexedVertices();

        // also render any shots!
        /*for(shot in shots) {
            g = shot.data.shot.target.photo.g4;
            g.begin();
            g.clear(bg, 1);
            g.setPipeline(postPipeline);
            
            g.setFloat4(paramsID, s.flash, s.transition, 1, 0);
            g.setFloat2(resolutionID, Game.state.w, Game.state.h);
            g.setTexture(texID, cam.renderBuffer);

            g.setVertexBuffer(vertexBuffer);
            g.setIndexBuffer(indexBuffer);
            g.drawIndexedVertices();

            // delete the shot now that we've taken it
            shot.entity.remove(shot.data.shot);
        }*/
    }
}
