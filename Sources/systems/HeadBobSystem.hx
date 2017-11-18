package systems;

import edge.ISystem;
import components.HeadBob;
import components.Velocity;
using glm.Vec2;

class HeadBobSystem implements ISystem {
    var flat:Vec2 = new Vec2();

    function update(c:HeadBob, v:Velocity) {
        flat.x = v.v.x * Game.state.dt_fixed;
        flat.y = v.v.z * Game.state.dt_fixed;
        c.distance += flat.length();

        c.currentMagnitude = Settings.headBobMagnitude * Math.abs(Math.sin(2 * Math.PI * Settings.headBobFrequency * c.distance));
    }
}
