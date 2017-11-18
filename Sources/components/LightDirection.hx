package components;

import edge.IComponent;
import glm.Vec3;

class LightDirection implements IComponent {
    var direction:Vec3;
    var colour:Vec3;

    public function new(?colour:Vec3) {
        this.direction = new Vec3(0, 1, 0);
        this.colour = colour == null ? new Vec3(1, 1, 1) : colour;
    }
}
