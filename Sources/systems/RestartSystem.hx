package systems;

import edge.ISystem;
import components.TotalDisplay;

class RestartSystem implements ISystem {
    public function update(d:TotalDisplay) {
        if(Game.state.restartPressed) {
            Game.engine.create([
                new components.LevelSwitch(1, 0)
            ]);
        }
    }
}
