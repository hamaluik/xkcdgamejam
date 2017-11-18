package components;

import edge.IComponent;

class Crouch implements IComponent {
    var transition:Float;
    var currentMagnitude:Float;

    public function new() {
        transition = 0;
        this.currentMagnitude = 0;
    }
}
