package components;

import edge.IComponent;
import haxe.ds.IntMap;
import types.TBun;

class Bun implements IComponent {
    static var _nextID = 0;
    public static var buns:IntMap<Bun> = new IntMap<Bun>();

    var id:Int;
    var name:String;
    var size:Float;
    var type:TBun;

    public function new(size:Float, type:TBun) {
        this.id = _nextID;
        this.name = utils.NameGenerator.generate(size);
        this.size = size;
        this.type = type;

        _nextID++;
        buns.set(this.id, this);
    }
}
