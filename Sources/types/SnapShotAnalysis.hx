package types;

import haxe.ds.IntMap;
import components.Bun;

@:allow(types.SnapShot)
class SnapShotAnalysis {
    public var score(default, null):Int;
    public var mainBun:Bun = null;

    function new(detectionResults:IntMap<Int>) {
        score = 0;
        var maxp:Float = Math.NEGATIVE_INFINITY;
        for(bid in detectionResults.keys()) {
            var bun:Bun = Bun.buns.get(bid);
            
            // 2; 0.5; 1.25;
            var sizeModifier:Float = (bun.size - Settings.minBunSize) / (Settings.maxBunSize - Settings.minBunSize); // 1; 0; 0.5
            sizeModifier = 1.0 - sizeModifier; // 0; 1; 0.5;
            sizeModifier += 1; // 1; 2; 1.5
            sizeModifier *= sizeModifier; // 1; 4; 2.25;

            var p:Float = detectionResults.get(bid) * sizeModifier;
            //score += Math.floor(p / 100);
            score += Std.int(p);

            if(p > maxp && p > 1000) {
                maxp = p;
                mainBun = bun;
            }
        }
    }
}
