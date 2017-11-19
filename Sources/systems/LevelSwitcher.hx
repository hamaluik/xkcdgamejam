package systems;

import edge.ISystem;
import components.LevelSwitch;

class LevelSwitcher implements ISystem {
    function update(s:LevelSwitch) {
        if(s.countdown <= 0) {
            Game.changeLevel(s.nextLevel);
        }

        s.countdown -= Game.state.dt_fixed;
    }
}
