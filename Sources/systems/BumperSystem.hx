package systems;

import edge.ISystem;
import edge.View;
import components.Transform;
import components.Bumper;
import components.Obstacle;
import headbutt.Headbutt2D;
using glm.Vec2;

class BumperSystem implements ISystem {
    var obstacles:View<{o:Obstacle, t:Transform}>;
    var hb:Headbutt2D;

    public function new() {
        hb = new Headbutt2D();
    }

    function before() {
        for(obstacle in obstacles) {
            var o:Obstacle = obstacle.data.o;
            var t:Transform = obstacle.data.t;
            o.shape.offset.x = t.pos.x;
            o.shape.offset.y = t.pos.z;
        }
    }

    function update(b:Bumper, t:Transform) {
        b.shape.offset.x = t.pos.x;
        b.shape.offset.y = t.pos.z;
        
        for(obstacle in obstacles) {
            var o:Obstacle = obstacle.data.o;
            var result:Null<Vec2> = hb.intersect(b.shape, o.shape);
            if(result != null) {
                t.pos.x -= result.x;
                t.pos.z -= result.y;
            }
        }
    }
}
