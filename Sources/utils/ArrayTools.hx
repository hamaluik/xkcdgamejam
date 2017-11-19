package utils;

import thx.Ints;
import thx.ReadonlyArray;

class ArrayTools {
    // modified from thx.core
    public static function shuffle<T>(a:ReadonlyArray<T>) : Array<T> {
        var t = Ints.range(a.length),
                array = [];
        while (t.length > 0) {
            var pos = Game.random.GetUpTo(t.length - 1),//Std.random(t.length),
                index = t[pos];
            t.splice(pos, 1);
            array.push(a[index]);
        }
        return array;
    }
}
