package data.levels;

import edge.Entity;
using glm.Vec3;
using glm.Quat;

class Level1 implements Level {
    public function new() {}

    public function load():Void {
        Game.engine.create([
            new components.Transform(
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
                new Vec3(0, 30, 0),
                Quat.fromEuler(-Math.PI/4, 0, 0, new Quat())
            )
        ]);

        for(n in Game.resources.forest) {
            var e:Entity = Game.engine.create([
                new components.Transform(n.pos),
                new components.MeshRender(n.mesh, n.bunFactor, Game.resources.palette)
            ]);
            if(n.radius > 0) {
                e.add(new components.Obstacle(n.radius));
            }
        }
    }

    public function unload():Void {

    }
}
