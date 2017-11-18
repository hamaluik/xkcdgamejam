package systems;

import edge.ISystem;
import components.Camera;
import components.SnapCamera;
import utils.FloatTools;

class PictureTakingSystem implements ISystem {
    function update(c:Camera, sc:SnapCamera) {
        if(Game.state.mousePressed && Math.abs(sc.transition - 1.0) <= 0.0001) {
            sc.snapping = true;
        }

        if(!sc.snapping) return;

        sc.flash =
            if(sc.flashFrame < 2)
                FloatTools.lerp(sc.flashFrame / 2, 0, 1);
            else if(sc.flashFrame > 6)
                FloatTools.lerp((sc.flashFrame - 6) / 2, 1, 0);
            else 1;

        sc.flashFrame++;
        if(sc.flashFrame > 8) {
            sc.snapping = false;
            sc.flash = 0;
            sc.flashFrame = 0;
        }
    }
}
