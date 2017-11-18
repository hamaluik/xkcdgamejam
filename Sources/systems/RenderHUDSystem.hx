package systems;

import kha.Color;
import edge.ISystem;
import components.Camera;

@:allow(Game)
class RenderHUDSystem implements ISystem {
    function new() {
    }

    function update(cam:Camera) {
        var g = Game.state.g2;
        g.begin(false);

        g.color = Color.White;
        g.fillRect(0, 0, 64, 64);

        g.end();
    }
}
