package systems;

import edge.ISystem;
import edge.Entity;
import components.ShotAnalysis;

class AdvanceShotAnalysisSystem implements ISystem {
    var entity:Entity;

    function update(a:ShotAnalysis) {
        if(!Game.state.mousePressed) return;
        
        if(a.shots[a.i].analysis.mainBun == null)
            a.stage = ShotAnalysisStage.Total;
        else
            a.stage++;
         
        if(a.stage > ShotAnalysisStage.Total) {
            a.i++;
            if(a.i < a.shots.length && a.shots[a.i] != null && a.shots[a.i].taken) {
                // advance!
                a.stage = ShotAnalysisStage.Intro;
                var sign:Float = a.angle < 0 ? 1 : -1;
                a.angle = sign * Game.random.GetFloatIn(Math.PI/96, Math.PI/48);
            }
            else {
                entity.destroy();
                Game.engine.create([
                    new components.TotalDisplay()
                ]);
            }
        }
    }
}
