package systems;

import edge.ISystem;
import components.LightDarken;
using utils.FloatTools;

class LightDarkenSystem implements ISystem {
    function update(l:LightDarken) {
        if(l.t >= Settings.minDaylightTime) {
            l.lightScale = FloatTools.lerp((l.t - Settings.minDaylightTime) / Settings.darkenTime, 1.0, Settings.minDarken);
            l.lightScale = l.lightScale.clamp(Settings.minDarken, 1);
        }
        else {
            l.lightScale = 1.0;
        }

        l.t += Game.state.dt_fixed;
        if(l.t >= Settings.minDaylightTime + Settings.darkenTime) l.t = Settings.minDaylightTime + Settings.darkenTime;
    }
}
