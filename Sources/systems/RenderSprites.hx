package systems;

import kha.System;
import kha.Color;
import edge.ISystem;
import components.Sprite;

class RenderSprites implements ISystem {
    public function new() {}

    public function before() {
        Game.state.g2.begin(true, Color.Black);
    }

    public function update(s:Sprite) {
        var g = Game.state.g2;

        g.color = Color.White;
        g.drawImage(s.image, s.pos.x, s.pos.y);
    }

    public function after() {
        Game.state.g2.end();
    }
}
