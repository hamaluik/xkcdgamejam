package systems;

import edge.ISystem;
import edge.Entity;
import kha.audio1.Audio;
import components.AudioSource;

class AudioPlayer implements ISystem {
    var entity:Entity;

    function update(source:AudioSource) {
        if(source.audio == null) {
            source.audio = Audio.play(source.sound, source.loop);
        }
        
        if(Game.mute) source.audio.volume = 0;
        else source.audio.volume = 1;

        if(!source.loop && source.audio.finished) {
            entity.destroy();
        }
    }
}
