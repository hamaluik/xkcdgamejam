package systems;

import kha.Color;
import edge.ISystem;
import components.Camera;
import components.SnapCamera;

@:allow(Game)
class RenderHUDSystem implements ISystem {
    function new() {
    }

    function update(cam:Camera, s:SnapCamera) {
        var g = Game.state.g2;
        g.begin(false);

        g.color = Color.fromFloats(1, 1, 1, s.transition);
        g.drawImage(Game.resources.cameraOverlay, 0, 0);

        g.end();
    }
}
