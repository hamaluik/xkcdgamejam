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
    var parent:Transform;

    public function new(?pos:Vec3, ?rot:Quat, ?sca:Vec3, ?parent:Transform) {
        this.pos = pos == null ? new Vec3(0, 0, 0) : pos;
        this.rot = rot == null ? Quat.identity(new Quat()) : rot;
        this.sca = sca == null ? new Vec3(1, 1, 1) : sca;
        this.parent = parent;

        m = new Mat4().identity();
    }
}
