package com.happyshiny.shoot.states;

import com.happyshiny.shoot.G;
import com.happyshiny.shoot.entities.Player;
import nme.Assets;
import nme.geom.Rectangle;
import nme.net.SharedObject;
import nme.Lib;
import nme.ui.Mouse;
import nme.events.KeyboardEvent;
import org.flixel.FlxButton;
import org.flixel.FlxG;
import org.flixel.FlxPath;
import org.flixel.FlxPoint;
import org.flixel.FlxSave;
import org.flixel.FlxSprite;
import org.flixel.FlxState;
import org.flixel.FlxText;
import org.flixel.FlxU;

import com.happyshiny.util.SoundManager;

class GameState extends FlxState
{
    public override function create():Void
    {
        super.create();

        G.resetState();

        // Keyboard events
        Lib.current.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);

        #if (web || desktop)
        FlxG.mouse.show();
        #end

        // GO!
        var t : FlxText = new FlxText(0, FlxG.height/2 - 150, FlxG.width, "GO!", 56, true);
        t.alignment = "center";
        add(t);
        t.flicker(1.0);
        FlxG.tween(t, { alpha: 0 }, 2.0);

        var t : FlxText = new FlxText(0, FlxG.height/2 + 150, FlxG.width, "GO!", 56, true);
        #if mobile
        t.y -= Std.int(t.height);
        #end
        t.angle = 180;
        t.alignment = "center";
        add(t);
        t.flicker(1.0);
        FlxG.tween(t, { alpha: 0 }, 2.0);
    }
    
    public function onKeyUp(e : KeyboardEvent):Void
    {
        // Space bar
        if (e.keyCode == 32)
        {
        }

        // Escape key (also Android back button)
        if (e.keyCode == 27)
        {
            e.stopImmediatePropagation();
            FlxG.switchState(new MenuState());
            destroy();
        }
    }

    public override function destroy():Void
    {
        Lib.current.stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);

        super.destroy();
    }

    public override function update():Void
    {
        super.update();

        G.update();
    }   
}
