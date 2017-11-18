package components;

import edge.IComponent;

class SnapCamera implements IComponent {
    var transition:Float;
    var snapping:Bool;
    var flash:Float;
    var flashFrame:Int;

    public function new() {
        transition = 0;
        snapping = false;
        flash = 0;
        flashFrame = 0;
    }
}
