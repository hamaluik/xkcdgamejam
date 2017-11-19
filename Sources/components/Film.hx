package components;

import edge.IComponent;
import types.SnapShot;
import haxe.ds.Vector;

class Film implements IComponent {
    var shots:Vector<SnapShot>;

    public function new() {
        shots = new Vector<SnapShot>(Settings.numShots);
        for(i in 0...shots.length) {
            shots[i] = new SnapShot();
        }
    }
}
