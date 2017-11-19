package components;

import edge.IComponent;
import kha.Sound;
import kha.audio1.AudioChannel;

class AudioSource implements IComponent {
    var sound:Sound;
    var audio:AudioChannel = null;
    var playing:Bool = false;
    var loop:Bool;

    public function new(sound:Sound, loop:Bool) {
        this.sound = sound;
        this.loop = loop;
    }
}
