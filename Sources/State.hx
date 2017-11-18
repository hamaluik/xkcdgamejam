@:allow(Game)
class State {
    function new() {}
    
    public var mouseX(default, null):Float = 0;
    public var mouseY(default, null):Float = 0;
    public var mouseDeltaX(default, null):Float = 0;
    public var mouseDeltaY(default, null):Float = 0;
    public var mouseDown(default, null):Bool = false;
    public var pointerLocked(default, null):Bool = false;

    public var time(default, null):Float =  0.0;
    public var dt_variable(default, null):Float =  0.0;
    public var dt_fixed(default, null):Float =  1/60;

    public var g2(default, null):kha.graphics2.Graphics =  null;
    public var g4(default, null):kha.graphics4.Graphics =  null;

    public var w(default, null):Int = 1;
    public var h(default, null):Int = 1;
}
