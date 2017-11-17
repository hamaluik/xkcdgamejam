import kha.System;
import kha.math.Random;
import kha.Framebuffer;
import edge.Engine;
import edge.Phase;
import glm.GLM;
using glm.Mat4;
using glm.Quat;
using glm.Vec4;
using glm.Vec3;
using glm.Vec2;

@:allow(Main)
class Game {
	public static var state(default, null):State;
    public static var engine(default, null):Engine;
    
    static var updatePhase:Phase;
    static var renderPhase:Phase;

    public static var random(default, null):Random;
    public static var resources(default, null):Resources;

    static function initialize():Void {
        // TODO: new seed each time
        random = new Random(0);
        resources = new Resources();
        
        // TODO: input functions

        state = new State();

		engine = new Engine();
        updatePhase = engine.createPhase();
        // TODO: add update systems

        renderPhase = engine.createPhase();
        // TODO: add render systems

        state.time = kha.Scheduler.time();
    }

    static function update():Void {
        state.w = System.windowWidth();
        state.h = System.windowHeight();

		var time:Float = kha.Scheduler.time();
		state.dt_variable = time - state.time;
		state.time = time;

        // TODO: process input

		updatePhase.update(0);
    }

    static function render(fb:Framebuffer):Void {
		state.g2 = fb.g2;
		state.g4 = fb.g4;
		renderPhase.update(0);
    }
}
