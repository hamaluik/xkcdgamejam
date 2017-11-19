package systems;

import kha.System;
import kha.Color;
import edge.ISystem;
import edge.View;

class RenderScores implements ISystem {
    public function new() {}

    public function before() {
        Game.state.g2.begin(false);
    }

    public function update() {
        var g = Game.state.g2;

        g.font = Game.resources.xkcdFont;
        g.fontSize = 24;
        g.color = Color.White;
        g.drawString("RANK:", 33, 61);
        g.drawString("SIZE:", 33, 61 + g.font.height(g.fontSize) + 4);
        g.drawString("FRIENDS:", 33, 61 + (g.font.height(g.fontSize) + 4) * 2);
        g.color = Color.fromBytes(255, 236, 39);
        g.drawString("TOTAL:", 33, 61 + (g.font.height(g.fontSize) + 4) * 3);

        var sw:Float = 0;
        g.color = Color.White;
        sw = g.font.width(g.fontSize, "1000");
        g.drawString("1000", 200-sw, 61);
        sw = g.font.width(g.fontSize, "100");
        g.drawString("100", 200-sw, 61 + g.font.height(g.fontSize) + 4);
        sw = g.font.width(g.fontSize, "x2");
        g.drawString("x2", 200-sw, 61 + (g.font.height(g.fontSize) + 4) * 2);
        g.color = Color.fromBytes(255, 236, 39);
        sw = g.font.width(g.fontSize, "2200");
        g.drawString("2200", 200-sw, 61 + (g.font.height(g.fontSize) + 4) * 3);

        g.color = Color.White;
        g.drawString("Let's see...", 178, 308);
    }

    public function after() {
        Game.state.g2.end();
    }
}
