package systems;

import edge.ISystem;
import components.Jump;

class JumpSystem implements ISystem {
    function update(j:Jump) {
        j.velocity -= Game.state.dt_fixed * Settings.jumpGravity;
        if(Game.state.jumpPressed && j.y < 0.0001) j.velocity = Settings.jumpSpeed;
        j.y += j.velocity * Game.state.dt_fixed;
        if(j.y < 0.0001) j.y = 0;
    }
}
