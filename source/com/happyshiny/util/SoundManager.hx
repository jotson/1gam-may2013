package com.happyshiny.util;

import nme.events.Event;
import nme.media.Sound;
import nme.media.SoundTransform;
import org.flixel.FlxG;
import org.flixel.FlxSound;

class SoundManager {
    public static var varmap : Hash<Array<String>>;

    /**
     * This method creats a map of keys to embedded sound IDs for the purpose
     * of playing random variants of a given sound using a single key.
     * @param key           : String The key that the sound will be known as
     * @param embeddedSound : String The actual embedded sound ID
     * @param loop          : Bool
     * @param channels      : Int
     */
    public static function add(key : String, embeddedSound : String) : Void
    {
        if (varmap == null)
        {
            varmap = new Hash<Array<String>>();
        }

        var m : Array<String>;
        if (varmap.exists(key)) {
            m = varmap.get(key);
        }
        else
        {
            m = new Array<String>();
        }

        #if android
        FlxG.addSound(embeddedSound);
        #end
        
        m.push(embeddedSound);
        varmap.set(key, m);
    }

    /**
     * Play a random variation of the sound represented by key.
     * If the key doesn't exist, then assume it is an embedded sound ID.
     * @param  key    :             String
     * @param  volume :             Float
     * @param  loop   :             Bool
     */
    public static function play(key : String, volume : Float = 1.0, loop : Bool = false) : Void
    {
        var embeddedSound = key;

        if (varmap.exists(key)) {
            // Choose a random variation
            var m = varmap.get(key);
            embeddedSound = m[Std.random(m.length)];
        }

        FlxG.play(embeddedSound, volume, loop);
    }

    public static function playMusic(embeddedSound : String, volume : Float = 1.0) : Void
    {
        #if android
        FlxG.addSound(embeddedSound);
        #end
        FlxG.playMusic(embeddedSound, volume);
    }
}
