package systems;

import edge.ISystem;
import components.Velocity;
import components.FootstepSFX;
using glm.Vec2;

class FootstepSFXSystem implements ISystem {
    var flat:Vec2 = new Vec2();

    function update(f:FootstepSFX, v:Velocity) {
        flat.x = v.v.x * Game.state.dt_fixed;
        flat.y = v.v.z * Game.state.dt_fixed;

        f.distance += flat.length();
        if(f.distance >= Settings.footStepDistance) {
            f.distance = 0;
            var nextFoot:TFoot = switch(f.lastFoot) {
                case Left: Right;
                case Right: Left;
            }
            f.lastFoot = nextFoot;
            Game.engine.create([
                new components.AudioSource(switch(nextFoot) {
                    case Left: Game.resources.footLeft;
                    case Right: Game.resources.footRight;
                }, false)
            ]);
        }
    }
}
