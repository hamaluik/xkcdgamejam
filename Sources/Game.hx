import kha.System;
import kha.math.Random;
import kha.Framebuffer;
import kha.input.Mouse;
import kha.input.Keyboard;
import kha.input.KeyCode;
import edge.Engine;
import edge.Phase;
import data.Level;

@:allow(Main)
class Game {
	public static var state(default, null):State;
    public static var engine(default, null):Engine;
    
    public static var updatePhase(default, null):Phase;
    public static var renderPhase(default, null):Phase;

    public static var random(default, null):Random;
    public static var resources(default, null):Resources;

    public static var mute(default, null):Bool = true; // TODO: make false for release!

    // TODO: starting at level 0 breaks shadows somehow!
    public static var currentLevel:Int = 0;
    public static var levels(default, null):Array<Level> = [
        new data.levels.Level0(),
        new data.levels.Level1(),
        new data.levels.Level2()
    ];

    public static function changeLevel(nextLevel:Int):Void {
        js.Browser.console.log('Changing level to: ', nextLevel);
        levels[currentLevel].unload();
        currentLevel = nextLevel;
        levels[currentLevel].load();
    }

    static function initialize():Void {
        // TODO: new seed each time
        random = new Random(0);
        resources = new Resources();

        Mouse.get(0).notify(
            function(b, x, y) {
                if(b == 0) {
                    state.mouseDown = true;
                    state.mousePressed = true;
                }
                else if(b == 1) state.inputRightMouse = true;
            },
            function(b, x, y) {
                if(b == 0) state.mouseDown = false;
                else if(b == 1) state.inputRightMouse = false;
            },
            function(x:Int, y:Int, mx:Int, my:Int):Void {
                state.mouseX = x;
                state.mouseY = y;
                state.mouseDeltaX = mx;
                state.mouseDeltaY = my;
            },
            null,
            null
        );
        Keyboard.get(0).notify(
            function(k:KeyCode):Void {
                switch(k) {
                    case W: state.inputForward = 1.0;
                    case S: state.inputBack = 1.0;
                    case D: state.inputRight = 1.0;
                    case A: state.inputLeft = 1.0;
                    case Shift: state.runDown = true;
                    case C: state.crouchDown = true;
                    case V: state.inputV = true;
                    case Space: {
                        state.jumpDown = true;
                        state.jumpPressed = true;
                    }
                    case M: mute = !mute;
                    default:
                }
            },
            function(k:KeyCode):Void {
                switch(k) {
                    case W: state.inputForward = 0.0;
                    case S: state.inputBack = 0.0;
                    case D: state.inputRight = 0.0;
                    case A: state.inputLeft = 0.0;
                    case Shift: state.runDown = false;
                    case C: state.crouchDown = false;
                    case V: state.inputV = false;
                    case Space: state.jumpDown = false;
                    default:
                }
            },
            null
        );
        kha.SystemImpl.notifyOfMouseLockChange(pointerLockChanged, function() {
            Game.state.pointerLocked = false;
        });

        state = new State();

		engine = new Engine();
        updatePhase = engine.createPhase();
        renderPhase = engine.createPhase();

        levels[currentLevel].load();

        state.time = kha.Scheduler.time();
    }

    static function update():Void {
        state.w = System.windowWidth();
        state.h = System.windowHeight();

		var time:Float = kha.Scheduler.time();
		state.dt_variable = time - state.time;
		state.time = time;

		updatePhase.update(0);

        state.mouseDeltaX = 0;
        state.mouseDeltaY = 0;
        state.jumpPressed = false;
        state.mousePressed = false;
    }

    static function render(fb:Framebuffer):Void {
		state.g2 = fb.g2;
		state.g4 = fb.g4;
		renderPhase.update(0);
    }

    public static function lockPointer():Void {
        kha.SystemImpl.khanvas.onclick = requestPointerLock;
    }

    public static function unlockPointer():Void {
        js.Browser.document.exitPointerLock();
    }

    static function requestPointerLock():Void {
        kha.SystemImpl.khanvas.requestPointerLock();
    }

    static function pointerLockChanged():Void {
        Game.state.pointerLocked = js.Browser.document.pointerLockElement == kha.SystemImpl.khanvas;
        if(Game.state.pointerLocked)
            kha.SystemImpl.khanvas.onclick = null;
        else
            kha.SystemImpl.khanvas.onclick = requestPointerLock;
    }
}
