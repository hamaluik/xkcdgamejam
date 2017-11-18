package components;

import edge.IComponent;

class HeadBob implements IComponent {
    var distance:Float;
    var currentMagnitude:Float;

    public function new() {
        distance = 0;
        this.currentMagnitude = 0;
    }
}
