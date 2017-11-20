package components;

import edge.IComponent;
import types.SnapShot;

@:enum abstract ShotAnalysisStage(Int) from Int to Int {
    var Intro = 0;
    var Rank = 1;
    var Size = 2;
    var Friends = 3;
    var Total = 4;

    @:op(A > B) static function gt(a:ShotAnalysisStage, b:ShotAnalysisStage):Bool;
    @:op(A >= B) static function gtt(a:ShotAnalysisStage, b:ShotAnalysisStage):Bool;
}

class ShotAnalysis implements IComponent {
    var i:Int;
    var shots:Array<SnapShot>;
    var stage:ShotAnalysisStage;
    var angle:Float;

    public function new(shots:Array<SnapShot>) {
        this.i = 0;
        this.shots = shots;
        this.stage = Intro;
        this.angle = Game.random.GetFloatIn(-Math.PI/48, Math.PI/48);
    }
}
