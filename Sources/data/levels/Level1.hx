package data.levels;

using glm.Vec3;
using glm.Quat;

class Level1 implements Level {
    public function new() {}

    public function load():Void {
        Game.engine.create([
            new components.Transform(
                new Vec3(0, 0, 5),
                new Quat().identity()
            ),
            new components.Camera(45, 0.1, 100),
            new components.MouseLook()
        ]);

        Game.engine.create([
            new components.LightDirection(
                new Vec3(1, 1, 1).normalize(new Vec3()),
                new Vec3(1, 1, 1)
            ),
            new components.LightAmbient(
                new Vec3(0.1, 0.1, 0.1)
            )
        ]);

        Game.engine.create([
            new components.Transform(),
            new components.MeshRender(Game.resources.cube, Game.resources.uvgrid)
        ]);
    }

    public function unload():Void {

    }
}