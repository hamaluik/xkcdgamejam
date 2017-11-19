package components;

import edge.IComponent;

class LightDarken implements IComponent {
    var t:Float;
    var lightScale:Float;

    public function new() {
        t = 0;
        lightScale = 1;
    }
}
