import glm.Vec2;

@:allow(Game)
class State {
    function new() {}
    
    // TODO: input variables

    public var time(default, null):Float =  0.0;
    public var dt_variable(default, null):Float =  0.0;
    public var dt_fixed(default, null):Float =  1/60;

    public var g2(default, null):kha.graphics2.Graphics =  null;
    public var g4(default, null):kha.graphics4.Graphics =  null;

    public var w(default, null):Int = 640;
    public var h(default, null):Int = 480;
}
