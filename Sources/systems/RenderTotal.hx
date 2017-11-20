package systems;

import kha.System;
import kha.Color;
import edge.ISystem;
import components.TotalDisplay;
using StringTools;

class RenderTotal implements ISystem {
    public function new() {}

    static var credits:Array<String> = [
        'CREDITS',
        '',
        'xkcd (c) Randall Munroe',
        'Design & Programming by Kenton Hamaluik',
        '',
        '"Low Poly Forest Pack" by Jaks is (c) Jaks',
        '"Rabbit" by Google is licensed under CC BY 3.0',
        '"XKCD-Regular" by Randall Munroe is licensed under CC BY-NC 2.5',
        'Rocky Mountain Outdoors: wind and birds" by Pete Buchwald',
        'is licensed under CC0 1.0',
        '"Camera Shutter Click 03" by Sound Jay is (c) Sound Jay',
        '"Footsteps in Forest - 01.mp3" by Gutek is licensed under CC0 1.0',
        '"Mute" by Rajive Sharma is licensed under CC BY 3.0 US',
        '"Targa Mono" by Cosimo Lorenzo Pancini',
        'is licensed under CC BY-NC 4.0',
    ];

    public function before() {
        Game.state.g2.begin(false);
    }

    function update(d:TotalDisplay) {
        var ww:Float = System.windowWidth(); var wh:Float = System.windowHeight();
        var g = Game.state.g2;

        g.font = Game.resources.xkcdFont;
        g.fontSize = 24;
        g.color = Color.White;

        var y:Float = 308;
        g.drawString('That comes to a total of ${d.grandTotal} points!', 178, y); y += g.font.height(g.fontSize) + 4;
        var x:Float = 178;
        var grade:String = grade(d.grandTotal);
        var n:String = grade.startsWith('A') ? 'n' : '';
        g.drawString('I\'ll give you a${n}: ', x, y);
        x += g.font.width(g.fontSize, 'I\'ll give you a${n}: ');
        g.color = Color.fromBytes(255, 236, 39);
        g.drawString(grade, x, y);

        g.color = Color.White;
        g.drawString("<c: credits> <r: restart>", Game.state.w - g.font.width(g.fontSize, "<c: credits> <r: restart>") - 8, Game.state.h - g.font.height(g.fontSize) - 8);

        if(Game.state.crouchDown) {
            g.end();
            g.begin(true, Color.Black);
            g.font = Game.resources.xkcdFont;
            g.fontSize = 24;
            g.color = Color.White;
            
            var h:Float = (credits.length * (g.font.height(g.fontSize) + 4)) - 4;
            var y:Float = (wh - h) / 2;
            for(credit in credits) {
                var x:Float = (ww - g.font.width(g.fontSize, credit)) / 2;
                g.drawString(credit, x, y);
                y += g.font.height(g.fontSize) + 4;
            }
        }
    }

    public function after() {
        Game.state.g2.end();
    }

    function grade(grandTotal:Int):String {
        if(grandTotal >= 12000) return "A+";
        if(grandTotal >= 9600) return "A";
        if(grandTotal >= 8400) return "A-";
        if(grandTotal >= 7200) return "B+";
        if(grandTotal >= 6000) return "B";
        if(grandTotal >= 4800) return "B-";
        if(grandTotal >= 3600) return "C+";
        if(grandTotal >= 2400) return "C";
        if(grandTotal >= 1200) return "C-";
        return "D";
    }
}
