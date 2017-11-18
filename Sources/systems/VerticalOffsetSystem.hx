package systems;

import edge.ISystem;
import components.Transform;
import components.Crouch;
import components.Jump;
import components.HeadBob;

class VerticalOffsetSystem implements ISystem {
    function update(t:Transform, c:Crouch, j:Jump, h:HeadBob) {
        t.pos.y = 1.6 - c.currentMagnitude + j.y + h.currentMagnitude;
    }
}
