package systems;

import edge.ISystem;
import components.Transform;
import components.Velocity;

class VelocitySystem implements ISystem {
    function update(t:Transform, vel:Velocity) {
        t.pos.x += vel.v.x * Game.state.dt_fixed;
        t.pos.y += vel.v.y * Game.state.dt_fixed;
        t.pos.z += vel.v.z * Game.state.dt_fixed;
    }
}
