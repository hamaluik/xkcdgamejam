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
    
    static var updatePhase:Phase;
    static var renderPhase:Phase;

    public static var random(default, null):Random;
    public static var resources(default, null):Resources;

    public static var currentLevel:Int = 0;
    public static var levels(default, null):Array<Level> = [
        new data.levels.Level1()
    ];

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
        updatePhase.add(new systems.FPSMovementSystem());
        updatePhase.add(new systems.CrouchSystem());
        updatePhase.add(new systems.JumpSystem());
        updatePhase.add(new systems.HeadBobSystem());
        updatePhase.add(new systems.VerticalOffsetSystem());
        updatePhase.add(new systems.MouseLookSystem());
        updatePhase.add(new systems.VelocitySystem());
        updatePhase.add(new systems.CameraZoomSystem());
        updatePhase.add(new systems.MatricesTransform());
        updatePhase.add(new systems.MatricesShadows());
        updatePhase.add(new systems.MatricesCamera());
        updatePhase.add(new systems.PictureTakingSystem());

        renderPhase = engine.createPhase();
        renderPhase.add(new systems.RenderShadows());
        renderPhase.add(new systems.Render());
        renderPhase.add(new systems.RenderPostProcessing());
        renderPhase.add(new systems.RenderHUDSystem());

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
