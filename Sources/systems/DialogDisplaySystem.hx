package systems;

import edge.ISystem;
import edge.Entity;
import components.DialogOverlay;
import utils.FloatTools;

class DialogDisplaySystem implements ISystem {
    var entity:Entity;

    function update(d:DialogOverlay) {
        if(d.delay > 0) {
            d.opacity = 0;
            d.delay -= Game.state.dt_fixed;
        }
        else {
            d.opacity =
                if(d.t < d.transitionTime) FloatTools.lerp(d.t / d.transitionTime, 0, 1);
                else if(d.t >= d.displayTime + d.transitionTime) FloatTools.lerp((d.t - d.displayTime - d.transitionTime) / d.transitionTime, 1, 0);
                else 1;
            d.opacity = FloatTools.clamp(d.opacity, 0, 1);

            d.t += Game.state.dt_fixed;
            if(d.t >= 2 * d.transitionTime + d.displayTime) {
                entity.destroy();
            }
        }
    }
}
