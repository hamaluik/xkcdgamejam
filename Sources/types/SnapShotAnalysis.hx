package types;

import haxe.ds.IntMap;
import haxe.ds.ObjectMap;
import components.Bun;

@:allow(types.SnapShot)
class SnapShotAnalysis {
    public var rank(default, null):Int;
    public var size(default, null):Int;
    public var friends(default, null):Int;
    public var total(default, null):Int;
    public var mainBun:Bun = null;

    public static var finalResults:ObjectMap<Bun, SnapShotAnalysis> = new ObjectMap<Bun, SnapShotAnalysis>();

    function new(detectionResults:IntMap<Int>) {
        rank = 0;
        size = 0;
        friends = 0;
        total = 0;

        var maxp:Float = Math.NEGATIVE_INFINITY;
        for(bid in detectionResults.keys()) {
            var bun:Bun = Bun.buns.get(bid);
            
            // 2; 0.5; 1.25;
            var sizeModifier:Float = (bun.size - Settings.minBunSize) / (Settings.maxBunSize - Settings.minBunSize); // 1; 0; 0.5
            sizeModifier = 1.0 - sizeModifier; // 0; 1; 0.5;
            sizeModifier += 1; // 1; 2; 1.5
            sizeModifier *= sizeModifier; // 1; 4; 2.25;

            var p:Float = detectionResults.get(bid) * sizeModifier;
            if(p > maxp && p > 1000) {
                maxp = p;
                mainBun = bun;

                rank = Std.int(500 * (1.0 - ((bun.size - Settings.minBunSize) / (Settings.maxBunSize - Settings.minBunSize))));
                if(bun.size < Settings.minBunSize) rank = 2000;
                size = Std.int(500 * (Math.sqrt(p) - 31) / (300 - 31));
                if(size < 50) size = 50;
            }
            if(p > 1000) {
                friends++;
            }
        }

        total = (rank + size) * friends;

        if(mainBun != null) {
            if(!finalResults.exists(mainBun)) {
                finalResults.set(mainBun, this);
            }
            if(total > finalResults.get(mainBun).total) {
                finalResults.set(mainBun, this);
            }
        }
    }
}
