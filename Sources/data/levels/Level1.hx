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
            new components.Bumper(0.5)
        ]);

        Game.engine.create([
            new components.LightDirection(
                new Vec3(1, 1, 1)
            ),
            new components.LightAmbient(
                new Vec3(0.1, 0.1, 0.1)
            ),
            new components.SunShadow(),
            new components.Transform(
                false,
                new Vec3(0, 30, 0),
                Quat.fromEuler(-Math.PI/4, 0, 0, new Quat())
            )
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

        // spawn Settings.numBuns bunnies, the first being the king which should be the furthest away
        var actualSpawns:Array<{ pos:Vec3, rot:Quat }> = Game.resources.bunSpawns.shuffle().slice(0, Settings.numBuns);
        actualSpawns.sort(function(a, b):Int {
            var amag:Float = a.pos.lengthSquared();
            var bmag:Float = b.pos.lengthSquared();
            if(amag > bmag) return -1;
            else if(amag < bmag) return 1;
            return 0;
        });
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
        
        Game.renderPhase.add(new systems.RenderShadows());
        Game.renderPhase.add(new systems.Render());
        Game.renderPhase.add(new systems.RenderPostProcessing());
        Game.renderPhase.add(new systems.RenderHUDSystem());
    }

    public function unload():Void {
        // TODO:
    }

    public function pause():Void {
        // TODO:
    }
    
    public function resume():Void {
        // TODO:
    }
}
