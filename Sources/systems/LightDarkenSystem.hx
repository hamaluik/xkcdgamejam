package systems;

import edge.ISystem;
import components.LightDarken;
using utils.FloatTools;

class LightDarkenSystem implements ISystem {
    function update(l:LightDarken) {
        l.lightScale = FloatTools.lerp(l.t / Settings.darkenTime, 1.0, Settings.minDarken);
        l.lightScale = l.lightScale.clamp(Settings.minDarken, 1);

        l.t += Game.state.dt_fixed;
        if(l.t >= Settings.darkenTime) l.t = Settings.darkenTime;
    }
}
