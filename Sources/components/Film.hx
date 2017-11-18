package components;

import edge.IComponent;
import types.SnapShot;
import haxe.ds.Vector;

class Film implements IComponent {
    var shots:Vector<SnapShot>;

    public function new() {
        shots = new Vector<SnapShot>(12);
        for(i in 0...12) {
            shots[i] = new SnapShot();
        }
    }
}
