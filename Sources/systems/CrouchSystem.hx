package systems;

import edge.ISystem;
import components.Crouch;
using utils.FloatTools;

class CrouchSystem implements ISystem {
    function update(c:Crouch) {
        var direction:Float = Game.state.crouchDown ? 1 : -1;
        c.transition += direction * Game.state.dt_fixed / Settings.crouchTime;
        c.transition = c.transition.clamp(0, 1);
        c.currentMagnitude = c.transition.lerp(0, Settings.crouchMagnitude);
        //js.Browser.console.log(c.currentMagnitude);
    }
}
