package data.levels;

import edge.Entity;
import types.TBun;
using glm.Vec4;
using glm.Vec3;
using glm.Quat;
using utils.ArrayTools;

class Level1 implements Level {
    public function new() {}

    var ambience:kha.audio1.AudioChannel;

    public function load():Void {
        Game.engine.create([
            new components.Transform(
                true,
                new Vec3(0, Settings.cameraHeight, 0),
                new Quat().identity()
            ),
            new components.Camera(45, 0.1, 100),
            new components.SnapCamera(),
            new components.MouseLook(),
            new components.Velocity(),
            new components.FPSMovement(),
            new components.HeadBob(),
            new components.Crouch(),
            new components.Jump(),
            new components.Film(),
            new components.Bumper(0.5),
            new components.FootstepSFX()
        ]);

        Game.engine.create([
            new components.LightDirection(
                new Vec3(1.5, 1.5, 1.5)
            ),
            new components.LightAmbient(
                new Vec3(0.1, 0.1, 0.1)
            ),
            new components.SunShadow(),
            new components.Transform(
                false,
                // TODO: fix placement and angle to get shadows working nicely
                new Vec3(0, 30, 0),
                Quat.fromEuler(-Math.PI/2, 0, 0, new Quat())
            )
        ]);

        Game.engine.create([
            new components.LightDarken()
        ]);

        var noBunFactor:Vec4 = new Vec4(0, 0, 0, 1);
        for(n in Game.resources.forest) {
            var e:Entity = Game.engine.create([
                new components.Transform(false, n.pos, n.rot),
                new components.MeshRender(n.mesh, noBunFactor, Game.resources.palette)
            ]);
            if(n.radius > 0) {
                e.add(new components.Obstacle(n.radius));
            }
        }

        // spawn Settings.numBuns bunnies, the first being the king ~~which should be the furthest away~~
        var actualSpawns:Array<{ pos:Vec3, rot:Quat }> = Game.resources.bunSpawns.shuffle().slice(0, Settings.numBuns);
        /*actualSpawns.sort(function(a, b):Int {
            var amag:Float = a.pos.lengthSquared();
            var bmag:Float = b.pos.lengthSquared();
            if(amag > bmag) return -1;
            else if(amag < bmag) return 1;
            return 0;
        });*/
        var kingSpawned:Bool = false;
        for(s in actualSpawns) {
            var size:Float = Game.random.GetFloatIn(Settings.minBunSize, Settings.maxBunSize);
            var itype:Int = kingSpawned? Game.random.GetIn(0, 1) : 2;
            var type:TBun = switch(itype) {
                case 1: Brown;
                case 2: King;
                case _: White;
            }
            var bunID:Vec4 = new Vec4(components.Bun._nextID / 255, 1, 1, 1);
            if(type.match(King)) {
                size = Settings.kingBunSize;
                kingSpawned = true;
            }

            Game.engine.create([
                new components.Transform(false, s.pos, s.rot, new Vec3(size, size, size)),
                new components.MeshRender(switch(type) {
                    case TBun.White: Game.resources.bun1;
                    case TBun.Brown: Game.resources.bun2;
                    case TBun.King: Game.resources.bunKing;
                }, bunID, Game.resources.palette),
                new components.Bun(size, type)
            ]);
        }

        Game.engine.create([
            new components.AudioSource(Game.resources.ambience, true)
        ]);

        Game.engine.create([
            new components.LevelSwitch(2, Settings.minDaylightTime + Settings.darkenTime)
        ]);

        Game.engine.create([
            new components.DialogOverlay("It's getting late!", 1, 3, 0.25)
        ]);
        Game.engine.create([
            new components.DialogOverlay("I need to make sure to photograph some buns for my report...", 1+3+0.5, 3, 0.25)
        ]);
        Game.engine.create([
            new components.DialogOverlay("... before it gets dark!", 1+3+0.5+3+0.5, 3, 0.25)
        ]);
        Game.engine.create([
            new components.DialogOverlay("There's gotta be *some* around here somewhere!", 1+3+0.5+3+0.5+3+0.5, 3, 0.25)
        ]);

        Game.updatePhase.add(new systems.FootstepSFXSystem());
        Game.updatePhase.add(new systems.LevelSwitcher());
        Game.updatePhase.add(new systems.AudioPlayer());
        Game.updatePhase.add(new systems.FPSMovementSystem());
        Game.updatePhase.add(new systems.CrouchSystem());
        Game.updatePhase.add(new systems.JumpSystem());
        Game.updatePhase.add(new systems.HeadBobSystem());
        Game.updatePhase.add(new systems.VerticalOffsetSystem());
        Game.updatePhase.add(new systems.MouseLookSystem());
        Game.updatePhase.add(new systems.VelocitySystem());
        Game.updatePhase.add(new systems.BumperSystem());
        Game.updatePhase.add(new systems.CameraZoomSystem());
        Game.updatePhase.add(new systems.MatricesTransform());
        Game.updatePhase.add(new systems.MatricesShadows());
        Game.updatePhase.add(new systems.MatricesCamera());
        Game.updatePhase.add(new systems.PictureTakingSystem());
        Game.updatePhase.add(new systems.LightDarkenSystem());
        Game.updatePhase.add(new systems.ShotDisplaySystem());
        Game.updatePhase.add(new systems.DialogDisplaySystem());
        
        Game.renderPhase.add(new systems.RenderShadows());
        Game.renderPhase.add(new systems.Render());
        Game.renderPhase.add(new systems.RenderPostProcessing());
        Game.renderPhase.add(new systems.RenderHUDSystem());
    }

    public function unload():Void {
        trace('going to post-action');
        // store the buns!
        Level2.buns = components.Bun.buns;
        for(entity in Game.engine.entities()) {
            if(entity.existsType(components.Film)) {
                Level2.film = entity.get(components.Film);
            }
        }

        // turn off all audio
        for(entity in Game.engine.entities()) {
            if(entity.existsType(components.AudioSource)) {
                var s:components.AudioSource = entity.get(components.AudioSource);
                s.audio.volume = 0;
                s.audio.stop();
            }
        }

        Game.unlockPointer();
        Game.renderPhase.clearSystems();
        Game.updatePhase.clearSystems();
        Game.engine.clear();
        Game.unlockPointer();
    }

    public function pause():Void {
        // TODO:
    }
    
    public function resume():Void {
        // TODO:
    }
}
