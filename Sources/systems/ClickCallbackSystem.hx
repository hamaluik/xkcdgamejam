package systems;

import edge.ISystem;
import edge.Entity;
import components.ClickCallback;

class ClickCallbackSystem implements ISystem {
    var entity:Entity;

    function update(c:ClickCallback) {
        if(Game.state.mousePressed) {
            c.cb();
            entity.destroy();
        }
    }
}
