package components;

import edge.IComponent;
using glm.Mat4;
import glm.Vec3;
import glm.Quat;

class Transform implements IComponent {
    var pos:Vec3;
    var rot:Quat;
    var sca:Vec3;
    var m:Mat4;
    var isDynamic:Bool;
    var dirty:Bool;

    public function new(isDynamic:Bool, ?pos:Vec3, ?rot:Quat, ?sca:Vec3) {
        this.pos = pos == null ? new Vec3(0, 0, 0) : pos;
        this.rot = rot == null ? Quat.identity(new Quat()) : rot;
        this.sca = sca == null ? new Vec3(1, 1, 1) : sca;
        this.isDynamic = isDynamic;
        dirty = true;

        m = new Mat4().identity();
    }
}
