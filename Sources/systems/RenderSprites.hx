package systems;

import kha.System;
import kha.Color;
import edge.ISystem;
import edge.View;
import components.Sprite;
import components.Transform;
import components.ClickCallback;

class RenderSprites implements ISystem {
    var clickCallbacks:View<{ccb:ClickCallback}>;

    public function new() {}

    public function before() {
        Game.state.g2.begin(true, Color.Black);
    }

    public function update(s:Sprite, t:Transform) {
        var g = Game.state.g2;

        g.color = Color.White;
        g.drawImage(s.image, t.pos.x, t.pos.y);

        var hascb:Bool = false;
        for(cb in clickCallbacks) {
            hascb = true;
            break;
        }
        if(hascb) {
            g.color = Color.White;
            g.font = Game.resources.xkcdFont;
            g.fontSize = 24;
            g.drawString("<click>", Game.state.w - g.font.width(g.fontSize, "<click>") - 8, Game.state.h - g.font.height(g.fontSize) - 8);
        }
    }

    public function after() {
        Game.state.g2.end();
    }
}
