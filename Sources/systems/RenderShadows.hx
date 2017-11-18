package systems;

import kha.Color;
import kha.Shaders;
import kha.graphics4.PipelineState;
import kha.graphics4.VertexStructure;
import kha.graphics4.VertexData;
import kha.graphics4.ConstantLocation;
import kha.graphics4.CullMode;
import kha.graphics4.CompareMode;
import edge.ISystem;
import edge.View;
import components.SunShadow;
import components.MeshRender;
import components.Transform;
using glm.Mat4;

@:allow(Game)
class RenderShadows implements ISystem {
    var renderables:View<{t:Transform, mr:MeshRender}>;

	var shadowPipeline:PipelineState;
	var mvpID:ConstantLocation;

    var bg:Color = Color.Black;
    var mvp:Mat4;

    function new() {
        // initialize everything!
        mvp = new Mat4();

        var structure = new VertexStructure();
        structure.add("position", VertexData.Float3);
        structure.add("normal",   VertexData.Float3);
        structure.add("texcoord", VertexData.Float2);

		shadowPipeline = new PipelineState();
		shadowPipeline.inputLayout = [structure];
		shadowPipeline.vertexShader = Shaders.shadow_vert;
		shadowPipeline.fragmentShader = Shaders.shadow_frag;
        shadowPipeline.cullMode = CullMode.Clockwise;
        shadowPipeline.depthMode = CompareMode.Less;
        shadowPipeline.depthWrite = true;

        try {
            shadowPipeline.compile();
        }
        catch(e:String) {
            #if js
            js.Browser.console.error(e);
            #else
            trace('ERROR:');
            trace(e);
            #end
        }

		mvpID = shadowPipeline.getConstantLocation("MVP");
    }

    function update(ss:SunShadow, t:Transform) {
        var g = ss.image.g4;
        //var g = Game.state.g4;
        g.begin();
        g.clear(bg, 1);
        g.setPipeline(shadowPipeline);

        for(target in renderables) {
            var rt:Transform = target.data.t;
            var rmr:MeshRender = target.data.mr;

            mvp = Mat4.multMat(ss.vp, rt.m, mvp);
            rmr.shadowMVP = mvp.copy(rmr.shadowMVP);
            g.setMatrix(mvpID, mvp);

            g.setVertexBuffer(rmr.mesh.vertexBuffer);
            g.setIndexBuffer(rmr.mesh.indexBuffer);
            g.drawIndexedVertices();
        }
    }
}
