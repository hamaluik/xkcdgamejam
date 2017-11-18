package components;

import edge.IComponent;
import glm.Vec3;

class Velocity implements IComponent {
    var v:Vec3;

    public function new(?v:Vec3) {
        this.v = v == null ? new Vec3(0, 0, 0) : v;
    }
}
