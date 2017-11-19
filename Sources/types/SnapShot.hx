package types;

import kha.Image;
import kha.System;
import kha.graphics4.TextureFormat;
import kha.graphics4.DepthStencilFormat;
import haxe.ds.IntMap;

class SnapShot {
    public var photo:Image = null;
    public var taken:Bool = false;
    
    public var lightScale:Float = 1.0;
    public var detectionResults(default, set):IntMap<Int> = null;
    public var analysis:SnapShotAnalysis = null;

    function set_detectionResults(r:IntMap<Int>):IntMap<Int> {
        this.detectionResults = r;
        analysis = new SnapShotAnalysis(r);
        return this.detectionResults;
    }

    public function new() {
        photo = Image.createRenderTarget(
            System.windowWidth(), System.windowHeight(),
            TextureFormat.RGBA32,
            DepthStencilFormat.DepthAutoStencilAuto
        );
    }
}
