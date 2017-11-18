package systems;

import edge.ISystem;
import edge.Entity;
import components.Camera;
import components.SnapCamera;
import components.Film;
import utils.FloatTools;

class PictureTakingSystem implements ISystem {
    var entity:Entity;

    function update(c:Camera, sc:SnapCamera, f:Film) {
        if(!sc.snapping && Game.state.mousePressed && Math.abs(sc.transition - 1.0) <= 0.0001) {
            var shotsTaken:Int = 0;
            var shotsTotal:Int = f.shots.length;
            for(shot in f.shots) {
                if(shot.taken) shotsTaken++;
            }
            if(shotsTaken < shotsTotal) {
                sc.snapping = true;
                
                f.shots[shotsTaken].taken = true;
                // TODO: take picture with bun detector
                // take a picture of the actual scene
                entity.add(new components.Shot(f.shots[shotsTaken]));

                // don't start flashing yet!
                return;
            }
        }

        if(!sc.snapping) return;

        sc.flash =
            if(sc.flashFrame < 2)
                FloatTools.lerp(sc.flashFrame / 2, 0, 1);
            else if(sc.flashFrame > 6)
                FloatTools.lerp((sc.flashFrame - 6) / 2, 1, 0);
            else 1;

        sc.flashFrame++;
        if(sc.flashFrame > 8) {
            sc.snapping = false;
            sc.flash = 0;
            sc.flashFrame = 0;
        }
    }
}
