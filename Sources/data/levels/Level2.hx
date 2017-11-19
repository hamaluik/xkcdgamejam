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
        for(bid in buns.keys()) {
            var bun:components.Bun = buns.get(bid);
            js.Browser.console.log('  ${bun.name} reporting in!');
        }
        for(i in 0...film.shots.length) {
            js.Browser.console.log('  shot ${i} analysis: ', film.shots[i].analysis);
        }
        
        Game.engine.create([
            new components.Sprite(Game.resources.teacher),
            new components.Transform(false, new Vec3(0, Game.state.h - Game.resources.teacher.height))
        ]);

        Game.renderPhase.add(new systems.RenderSprites());
        Game.renderPhase.add(new systems.RenderScores());

        Game.unlockPointer();
    }

    public function unload():Void {
        Game.renderPhase.clearSystems();
        Game.updatePhase.clearSystems();
        Game.engine.clear();
    }

    public function pause():Void {
        // TODO:
    }
    
    public function resume():Void {
        // TODO:
    }
}
