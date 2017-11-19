package components;

import edge.IComponent;

class DialogOverlay implements IComponent {
    var dialog:String;
    var delay:Float;
    var displayTime:Float;
    var transitionTime:Float;
    var opacity:Float;
    var t:Float;

    public function new(dialog:String, delay:Float, displayTime:Float, transitionTime:Float) {
        this.dialog = dialog;
        this.delay = delay;
        this.displayTime = displayTime;
        this.transitionTime = transitionTime;
        this.opacity = 0;
        this.t = 0;
    }
}
