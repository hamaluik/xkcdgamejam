package data.levels;

import data.Level;
import glm.Vec2;
import kha.System;
import glm.Vec3;

class Level0 implements Level {
    public function new() {}

    public function load():Void {
        Game.engine.create([
            new components.Sprite(Game.resources.comic),
            new components.Transform(true, new Vec3(0, (System.windowHeight()-Game.resources.comic.height)/2, 0))
        ]);

        Game.lockPointer();
        Game.engine.create([
            new components.ClickCallback(function() {
                Game.engine.create([
                    new components.LevelSwitch(1, 0.0)
                ]);
            })
        ]);

        Game.updatePhase.add(new systems.ClickCallbackSystem());
        Game.updatePhase.add(new systems.LevelSwitcher());

        Game.renderPhase.add(new systems.RenderSprites());
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
