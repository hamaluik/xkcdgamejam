@:allow(Game)
class State {
    function new() {}
    
    public var mouseX(default, null):Float = 0;
    public var mouseY(default, null):Float = 0;
    public var mouseDeltaX(default, null):Float = 0;
    public var mouseDeltaY(default, null):Float = 0;

    public var mouseDown(default, null):Bool = false;
    public var mousePressed(default, null):Bool = false;

    public var runDown(default, null):Bool = false;
    public var crouchDown(default, null):Bool = false;
    public var camDown(get, never):Bool;
    function get_camDown():Bool {
        return inputV || inputRightMouse;
    }
    public var jumpDown(default, null):Bool = false;
    public var jumpPressed(default, null):Bool = false;

    public var pointerLocked(default, null):Bool = false;

    var inputV:Bool = false;
    var inputRightMouse = false;
    var inputForward:Float = 0;
    var inputBack:Float = 0;
    var inputRight:Float = 0;
    var inputLeft:Float = 0;

    public var restartPressed(default, null):Bool = false;

    public var forwardBackwardAxis(get, never):Float;
    function get_forwardBackwardAxis():Float {
        return inputForward - inputBack;
    }
    public var rightLeftAxis(get, never):Float;
    function get_rightLeftAxis():Float {
        return inputRight - inputLeft;
    }

    public var time(default, null):Float =  0.0;
    public var dt_variable(default, null):Float =  0.0;
    public var dt_fixed(default, null):Float =  1/60;

    public var g2(default, null):kha.graphics2.Graphics =  null;
    public var g4(default, null):kha.graphics4.Graphics =  null;

    public var w(default, null):Int = 1;
    public var h(default, null):Int = 1;
}
