package systems;

import kha.System;
import kha.Color;
import edge.ISystem;
import edge.View;
import components.Camera;
import components.SnapCamera;
import components.Film;
import components.ShotDisplay;

class RenderHUDSystem implements ISystem {
    var shotDisplays:View<{d:ShotDisplay}>;

    public function new() {}

    function update(cam:Camera, s:SnapCamera, f:Film) {
        var shotsTaken:Int = 0;
        var shotsTotal:Int = f.shots.length;
        for(shot in f.shots) {
            if(shot.taken) shotsTaken++;
        }

        var g = Game.state.g2;
        g.begin(false);

        g.color = Color.fromFloats(1, 1, 1, s.transition);
        g.drawImage(Game.resources.cameraOverlay, 0, 0);

        g.font = Game.resources.font;
        g.fontSize = 32;
        var shotsLeft:Int = Settings.numShots - shotsTaken;
        g.drawString((shotsLeft < 10 ? '0' : '') + '${shotsLeft}/${shotsTotal}', 570, 430);

        if(Game.mute) {
            g.drawImage(Game.resources.muteIcon, 10, 4);
        }

        // render the last shot we took
        var ww:Float = System.windowWidth(); var wh:Float = System.windowHeight();
        g.pushRotation(-Math.PI/48, ww / 2, wh / 2);
        g.fontSize = 24;
        for(sh in shotDisplays) {
            g.color = Color.fromFloats(1, 1, 1, sh.data.d.opacity);
            var w:Float = ww * 0.75; var h:Float = wh * 0.75;
            var bw:Float = ww * 0.85; var bh:Float = wh * 0.85;
            g.fillRect((ww - bw) / 2, (wh - bh) / 2, bw, bh); // white background / outline
            g.drawScaledImage(sh.data.d.shot.photo, (ww - w) / 2, (wh - h) / 2, w, h); // the actual photo
            var caption:String =
                if(sh.data.d.shot.analysis.mainBun == null)
                    "???";
                else
                    sh.data.d.shot.analysis.mainBun.name;
            
            // position the caption text centered on the bottom white outline
            var sw:Float = Game.resources.font.width(g.fontSize, caption);
            g.color = Color.fromFloats(0, 0, 0, sh.data.d.opacity);
            var dh:Float = (bh - h) / 2;
            g.drawString(caption, (ww - sw) / 2, (wh + h) / 2 + (dh - g.font.height(g.fontSize)) / 2);
        }
        g.popTransformation();

        g.end();
    }
}
