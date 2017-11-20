package systems;

import kha.System;
import kha.Color;
import edge.ISystem;
import edge.View;
import components.ShotAnalysis;

class RenderScores implements ISystem {
    public function new() {}

    public function before() {
        Game.state.g2.begin(false);
    }

    public function update(a:ShotAnalysis) {
        var ww:Float = System.windowWidth(); var wh:Float = System.windowHeight();
        var g = Game.state.g2;

        g.font = Game.resources.xkcdFont;
        g.fontSize = 24;
        g.color = Color.White;

        var w:Float = ww * 0.45; var h:Float = wh * 0.45;
        var bw:Float = ww * 0.5; var bh:Float = wh * 0.5;
        g.pushRotation(a.angle, 0.5 * ww, 0.5 * wh);
        g.pushTranslation(ww/5, wh/-5);
            g.fillRect((ww - bw) / 2, (wh - bh) / 2, bw, bh); // white background / outline
            g.drawScaledImage(a.shots[a.i].photo, (ww - w) / 2, (wh - h) / 2, w, h); // the actual photo
        g.popTransformation();
        g.popTransformation();

        g.drawString("RANK:", 33, 61);
        g.drawString("SIZE:", 33, 61 + g.font.height(g.fontSize) + 4);
        g.drawString("FRIENDS:", 33, 61 + (g.font.height(g.fontSize) + 4) * 2);
        g.color = Color.fromBytes(255, 236, 39);
        g.drawString("TOTAL:", 33, 61 + (g.font.height(g.fontSize) + 4) * 3);

        var sw:Float = 0;
        g.color = Color.White;
        if(a.stage >= ShotAnalysisStage.Rank) {
            sw = g.font.width(g.fontSize, Std.string(a.shots[a.i].analysis.rank));
            g.drawString(Std.string(a.shots[a.i].analysis.rank), 200-sw, 61);
        }
        if(a.stage >= ShotAnalysisStage.Size) {
            sw = g.font.width(g.fontSize, Std.string(a.shots[a.i].analysis.size));
            g.drawString(Std.string(a.shots[a.i].analysis.size), 200-sw, 61 + g.font.height(g.fontSize) + 4);
        }
        if(a.stage >= ShotAnalysisStage.Friends) {
            sw = g.font.width(g.fontSize, "×" + Std.string(a.shots[a.i].analysis.friends));
            g.drawString("×" + Std.string(a.shots[a.i].analysis.friends), 200-sw, 61 + (g.font.height(g.fontSize) + 4) * 2);
        }
        if(a.stage >= ShotAnalysisStage.Total) {
            g.color = Color.fromBytes(255, 236, 39);
            sw = g.font.width(g.fontSize, Std.string(a.shots[a.i].analysis.total));
            g.drawString(Std.string(a.shots[a.i].analysis.total), 200-sw, 61 + (g.font.height(g.fontSize) + 4) * 3);
        }

        g.color = Color.White;
        var y:Float = 308;
        g.drawString("Let's see...", 178, y); y += g.font.height(g.fontSize) + 4;
        var nameString:String =
            if(a.shots[a.i].analysis.mainBun != null) 'That looks like ${a.shots[a.i].analysis.mainBun.name}!';
            else "I can't make out any buns in this one...";
        g.drawString(nameString, 178, y); y += g.font.height(g.fontSize) + 4;
        
        if(a.stage >= ShotAnalysisStage.Rank && a.shots[a.i].analysis.mainBun != null) {
            g.drawString(rankToString(a.shots[a.i].analysis.rank), 178, y); y += g.font.height(g.fontSize) + 4;
        }
        if(a.stage >= ShotAnalysisStage.Size && a.shots[a.i].analysis.mainBun != null) {
            g.drawString(sizeToString(a.shots[a.i].analysis.size), 178, y); y += g.font.height(g.fontSize) + 4;
        }
        if(a.stage >= ShotAnalysisStage.Friends && a.shots[a.i].analysis.mainBun != null) {
            g.drawString(friendsToString(a.shots[a.i].analysis.friends), 178, y); y += g.font.height(g.fontSize) + 4;
        }
        if(a.stage >= ShotAnalysisStage.Total && a.shots[a.i].analysis.mainBun != null) {
            g.drawString(totalToString(a.shots[a.i].analysis.total), 178, y); y += g.font.height(g.fontSize) + 4;
        }
        
        g.drawString("<click>", Game.state.w - g.font.width(g.fontSize, "<click>") - 8, Game.state.h - g.font.height(g.fontSize) - 8);
    }

    public function after() {
        Game.state.g2.end();
    }

    function rankToString(rank:Int):String {
        if(rank >= 1000) return "The most majestic of buns!";
        if(rank >= 350) return "A stunning bun!";
        if(rank >= 150) return "That's a mighty fine bun you have there!";
        return "The bun is a little large...";
    }

    function sizeToString(size:Int):String {
        if(size >= 400) return "The photo is excellently framed!";
        if(size >= 250) return "I can easily see its fuzz!";
        if(size >= 100) return "You could get a bit closer next time.";
        return "I can barely see the bun.";
    }

    function friendsToString(friends:Int):String {
        return switch(friends) {
            case 1: "A beautiful portrait!";
            case 2: "The bun has a friend!";
            case _: "SO MANY BUNS!";
        };
    }

    function totalToString(total:Int):String {
        if(total >= 1000) return "I can't imagine a better photo!";
        if(total >= 700) return "An all around great photo!";
        if(total >= 400) return "It's a decent photo!";
        if(total >= 100) return "Eh, I've seen better.";
        return "Let's hope the next one is better...";
    }
}
