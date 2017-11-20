package data.levels;

import kha.System;
import data.Level;
import haxe.ds.IntMap;
import glm.Vec3;

class Level2 implements Level {
    @:allow(data.levels.Level1)
    static var buns:IntMap<components.Bun>;
    @:allow(data.levels.Level1)
    static var film:components.Film;

    public function new() {}

    public function load():Void {
        js.Browser.console.log('post-action loaded');
        /*for(bid in buns.keys()) {
            var bun:components.Bun = buns.get(bid);
            js.Browser.console.log('  ${bun.name} reporting in!');
        }
        for(i in 0...film.shots.length) {
            js.Browser.console.log('  shot ${i} analysis: ', film.shots[i].analysis);
        }*/
        
        Game.engine.create([
            new components.Sprite(Game.resources.teacher),
            new components.Transform(false, new Vec3(0, Game.state.h - Game.resources.teacher.height))
        ]);

        var hasTakenAnyShots:Bool = false;
        if(film != null) {
            for(shot in film.shots) {
                if(shot.taken) {
                    hasTakenAnyShots = true;
                    break;
                }
            }
        }
        if(hasTakenAnyShots) {
            Game.engine.create([
                new components.ShotAnalysis(film.shots.toArray())
            ]);
        }
        else {
            Game.engine.create([
                new components.TotalDisplay()
            ]);
        }

        Game.updatePhase.add(new systems.AdvanceShotAnalysisSystem());
        Game.updatePhase.add(new systems.RestartSystem());
        Game.updatePhase.add(new systems.LevelSwitcher());

        Game.renderPhase.add(new systems.RenderSprites());
        Game.renderPhase.add(new systems.RenderScores());
        Game.renderPhase.add(new systems.RenderTotal());
    }

    public function unload():Void {
        Game.renderPhase.clearSystems();
        Game.updatePhase.clearSystems();
        Game.engine.clear();

        types.SnapShotAnalysis.finalResults = new haxe.ds.ObjectMap<components.Bun, types.SnapShotAnalysis>();
    }

    public function pause():Void {
        // TODO:
    }
    
    public function resume():Void {
        // TODO:
    }
}
