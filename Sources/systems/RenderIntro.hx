package systems;

import kha.System;
import kha.Color;
import edge.ISystem;
import components.IntroSprite;

class RenderIntro implements ISystem {
    public function new() {}

    public function before() {
        Game.state.g2.begin(true, Color.Black);
    }

    public function update(s:IntroSprite) {
        var ww:Float = System.windowWidth(); var wh:Float = System.windowHeight();
        var g = Game.state.g2;

        g.color = Color.White;
        g.drawImage(s.image, (ww - s.image.width) / 2, (wh - s.image.height) / 2);
    }

    public function after() {
        Game.state.g2.end();
    }
}
