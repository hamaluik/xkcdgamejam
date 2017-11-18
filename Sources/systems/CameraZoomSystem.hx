package systems;

import edge.ISystem;
import components.Camera;
import components.SnapCamera;
using utils.FloatTools;

class CameraZoomSystem implements ISystem {
    function update(c:Camera, s:SnapCamera) {
        var direction:Float = Game.state.camDown ? 1 : -1;
        s.transition += direction * Game.state.dt_fixed / Settings.cameraSnapFoVTime;
        s.transition = s.transition.clamp(0, 1);
        c.fov = s.transition.lerp(Settings.cameraFoV, Settings.cameraFoVSnapping);
    }
}
