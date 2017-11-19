import kha.System;
import kha.Scheduler;
import kha.Assets;

class Main {
    public static function main() {
        System.init({ title: "Bun Snap", width: 640, height: 480}, function() {

            Assets.loadEverything(function():Void {
                Game.initialize();
                System.notifyOnRender(Game.render);
                Scheduler.addTimeTask(Game.update, 0, 1/60);
            });
        });
    }

    public static function hideLoading():Void {
        var e = js.Browser.document.getElementById('loading');
        if(e != null) e.parentElement.removeChild(e);
    }
}
