package components;

import edge.IComponent;

enum TFoot {
    Left;
    Right;
}

class FootstepSFX implements IComponent {
    var distance:Float;
    var lastFoot:TFoot;

    public function new() {
        distance = 0;
        lastFoot = Right;
    }
}
