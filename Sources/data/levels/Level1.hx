package data.levels;

using glm.Vec3;
using glm.Quat;

class Level1 implements Level {
    public function new() {}

    public function load():Void {
        Game.engine.create([
            new components.Transform(
                new Vec3(0, 1.6, 5),
                new Quat().identity()
            ),
            new components.Camera(45, 0.1, 100),
            new components.MouseLook(),
            new components.Velocity(),
            new components.FPSMovement(5.0)
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
            Game.engine.create([
                new components.Transform(n.pos),
                new components.MeshRender(n.mesh, Game.resources.palette)
            ]);
        }
    }

    public function unload():Void {

    }
}
