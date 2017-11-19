package systems;

import edge.ISystem;
import components.Transform;
import components.Velocity;
using glm.Vec2;

class VelocitySystem implements ISystem {
    var v:Vec2 = new Vec2();

    function update(t:Transform, vel:Velocity) {
        t.pos.x += vel.v.x * Game.state.dt_fixed;
        t.pos.y += vel.v.y * Game.state.dt_fixed;
        t.pos.z += vel.v.z * Game.state.dt_fixed;

        // TODO: move boundary check to its own system!
        v.x = t.pos.x;
        v.y = t.pos.z;
        if(v.length() > 49) {
            v.normalize(v);
            v.multiplyScalar(49, v);
            t.pos.x = v.x;
            t.pos.z = v.y;
        }
    }
}
