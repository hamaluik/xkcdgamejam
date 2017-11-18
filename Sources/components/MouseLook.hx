package components;

import edge.IComponent;

class MouseLook implements IComponent {
    public var elevation:Float = 0;
    public var direction:Float = 0;

    public var smoothX:Float = 0;
    public var smoothY:Float = 0;

    public function new() {}
}
