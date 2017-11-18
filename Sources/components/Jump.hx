package components;

import edge.IComponent;

class Jump implements IComponent {
    var velocity:Float;
    var y:Float;

    public function new() {
        velocity = 0;
        y = 0;
    }
}
