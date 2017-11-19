package components;

import edge.IComponent;
import types.SnapShot;

class ShotDisplay implements IComponent {
    var shot:SnapShot;
    var t:Float;
    var opacity:Float;
    var rotation:Float;

    public function new(shot:SnapShot) {
        this.shot = shot;
        this.t = 0;
        this.opacity = 0;
        this.rotation = Game.random.GetFloatIn(-Math.PI/48, Math.PI/48);
    }
}
