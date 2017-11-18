package components;

import edge.IComponent;
import headbutt.shapes.Circle;

class Obstacle implements IComponent {
    var shape:Circle;

    public function new(radius:Float) {
        shape = new Circle(radius);
    }
}
