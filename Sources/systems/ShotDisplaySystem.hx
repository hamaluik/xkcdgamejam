package systems;

import edge.ISystem;
import edge.Entity;
import components.ShotDisplay;
using utils.FloatTools;

class ShotDisplaySystem implements ISystem {
    var entity:Entity;

    function update(d:ShotDisplay) {
        d.opacity =
            if(d.t < Settings.shotDisplayTime) 1;
            else FloatTools.lerp((d.t - Settings.shotDisplayTime)/Settings.shotDisplayFadeTime, 1, 0);
        d.opacity = d.opacity.clamp(0, 1);

        d.t += Game.state.dt_fixed;
        if(d.t >= Settings.shotDisplayTime + Settings.shotDisplayFadeTime) {
            entity.destroy();
        }
    }
}
