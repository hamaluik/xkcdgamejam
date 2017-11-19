package data.levels;

import data.Level;
import glm.Vec2;
import kha.System;

class Level0 implements Level {
    public function new() {}

    public function load():Void {
        Game.engine.create([
            new components.Sprite(
                new Vec2((System.windowWidth() - Game.resources.bmgLogo.width) / 2, (System.windowHeight() - Game.resources.bmgLogo.height) / 2),
                Game.resources.bmgLogo
            )
        ]);

        Game.engine.create([
            new components.LevelSwitch(1, 2.0)
        ]);

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
