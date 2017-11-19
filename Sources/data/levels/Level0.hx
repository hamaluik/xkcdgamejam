package data.levels;

import data.Level;

class Level0 implements Level {
    public function new() {}

    public function load():Void {
        Game.engine.create([
            new components.IntroSprite(Game.resources.bmgLogo)
        ]);

        Game.engine.create([
            new components.LevelSwitch(1, 2.0)
        ]);

        Game.updatePhase.add(new systems.LevelSwitcher());

        Game.renderPhase.add(new systems.RenderIntro());
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
