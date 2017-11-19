package systems;

import kha.Color;
import kha.Shaders;
import kha.Image;
import kha.System;
import kha.graphics4.TextureFormat;
import kha.graphics4.DepthStencilFormat;
import kha.graphics4.PipelineState;
import kha.graphics4.VertexStructure;
import kha.graphics4.VertexData;
import kha.graphics4.ConstantLocation;
import kha.graphics4.CullMode;
import kha.graphics4.CompareMode;
import edge.ISystem;
import edge.View;
import edge.Entity;
import components.MeshRender;
import components.Transform;
import components.Camera;
import components.SnapCamera;
import components.Film;
import components.LightDarken;
import utils.FloatTools;
import types.SnapShot;
import haxe.io.Bytes;
import haxe.ds.IntMap;
using glm.Mat4;

class PictureTakingSystem implements ISystem {
    var entity:Entity;
    var renderables:View<{t:Transform, mr:MeshRender}>;
    var lightDarkens:View<{ld:LightDarken}>;

	var bunDetectorPipeline:PipelineState;
	var mvpID:ConstantLocation;
	var bunFactorID:ConstantLocation;

    var bg:Color = Color.Black;
    var mvp:Mat4;

    var detectorImage:Image;

    public function new() {
        // initialize everything!
        mvp = new Mat4();

        var structure = new VertexStructure();
        structure.add("position", VertexData.Float3);
        structure.add("normal",   VertexData.Float3);
        structure.add("texcoord", VertexData.Float2);

		bunDetectorPipeline = new PipelineState();
		bunDetectorPipeline.inputLayout = [structure];
		bunDetectorPipeline.vertexShader = Shaders.bundetector_vert;
		bunDetectorPipeline.fragmentShader = Shaders.bundetector_frag;
        bunDetectorPipeline.cullMode = CullMode.Clockwise;
        bunDetectorPipeline.depthMode = CompareMode.Less;
        bunDetectorPipeline.depthWrite = true;

        detectorImage = Image.createRenderTarget(
            System.windowWidth(), System.windowHeight(),
            TextureFormat.RGBA32,
            DepthStencilFormat.DepthAutoStencilAuto
        );

        try {
            bunDetectorPipeline.compile();
        }
        catch(e:String) {
            #if js
            js.Browser.console.error(e);
            #else
            trace('ERROR:');
            trace(e);
            #end
        }

		mvpID = bunDetectorPipeline.getConstantLocation("MVP");
		bunFactorID = bunDetectorPipeline.getConstantLocation("bunFactor");
    }

    function update(c:Camera, sc:SnapCamera, f:Film) {
        if(!sc.snapping && Game.state.mousePressed && Math.abs(sc.transition - 1.0) <= 0.0001) {
            var shotsTaken:Int = 0;
            var shotsTotal:Int = f.shots.length;
            for(shot in f.shots) {
                if(shot.taken) shotsTaken++;
            }
            if(shotsTaken < shotsTotal) {
                sc.snapping = true;

                // store the lightScale value for this shot
                var lightScale:Float = 1;
                for(d in lightDarkens) {
                    if(d.data.ld.lightScale < lightScale) {
                        lightScale = d.data.ld.lightScale;
                    }
                }
                f.shots[shotsTaken].lightScale = lightScale;
                
                f.shots[shotsTaken].taken = true;
                // take picture with bun detector
                detectBuns(c, f.shots[shotsTaken]);
                // take a picture of the actual scene
                entity.add(new components.Shot(f.shots[shotsTaken]));
                // render it on the HUD for a bit
                Game.engine.create([
                    new components.ShotDisplay(f.shots[shotsTaken])
                ]);

                // don't start flashing yet!
                return;
            }
        }

        if(!sc.snapping) return;

        sc.flash =
            if(sc.flashFrame < 2)
                FloatTools.lerp(sc.flashFrame / 2, 0, 1);
            else if(sc.flashFrame > 6)
                FloatTools.lerp((sc.flashFrame - 6) / 2, 1, 0);
            else 1;

        sc.flashFrame++;
        if(sc.flashFrame > 8) {
            sc.snapping = false;
            sc.flash = 0;
            sc.flashFrame = 0;
        }
    }

    function detectBuns(cam:Camera, snapShot:SnapShot) {
        // render the buns!
        var g = detectorImage.g4;
        g.begin();
        g.clear(bg, 1);
        g.setPipeline(bunDetectorPipeline);

        for(target in renderables) {
            var t:Transform = target.data.t;
            var mr:MeshRender = target.data.mr;

            mvp = Mat4.multMat(cam.vp, t.m, mvp);
            g.setMatrix(mvpID, mvp);
            g.setVector4(bunFactorID, mr.bunFactor);

            g.setVertexBuffer(mr.mesh.vertexBuffer);
            g.setIndexBuffer(mr.mesh.indexBuffer);
            g.drawIndexedVertices();
        }

        // calculate the result
        var results:IntMap<Int> = new IntMap<Int>();
        var pixelData:Bytes = detectorImage.getPixels();
        for(i in 0...(detectorImage.width * detectorImage.height)) {
            var colour:Color = pixelData.getInt32(i * 4);
            if(colour.Rb != 0 && colour.Gb != 0) {
                // found a bun!
                if(!results.exists(colour.Bb)) {
                    results.set(colour.Bb, 0);
                }
                results.set(colour.Bb, results.get(colour.Bb) + 1);
            }
        }
        // TODO: store bun alignment

        // store the results!
        snapShot.detectionResults = results;

        js.Browser.console.log('Bun report:');
        for(key in results.keys()) {
            js.Browser.console.log('  ${components.Bun.buns.get(key).name} => ${results.get(key)}');
        }
        js.Browser.console.log('Score: ', snapShot.analysis.score);
    }
}
