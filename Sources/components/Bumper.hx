package components;

import edge.IComponent;
import headbutt.shapes.Circle;

class Bumper implements IComponent {
    var shape:Circle;

    public function new(radius:Float) {
        shape = new Circle(radius);
    }
}
