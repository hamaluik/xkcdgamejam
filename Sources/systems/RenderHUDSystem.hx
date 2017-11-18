package systems;

import kha.Color;
import edge.ISystem;
import components.Camera;
import components.SnapCamera;
import components.Film;

@:allow(Game)
class RenderHUDSystem implements ISystem {
    function new() {
    }

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
        g.drawString('${12 - shotsTaken}/${shotsTotal}', 525, 428);

        if(shotsTaken > 0) {
            g.color = Color.White;
            g.drawScaledImage(
                f.shots[shotsTaken - 1].photo,
                0, 0,
                80, 60
            );
        }

        g.end();
    }
}
