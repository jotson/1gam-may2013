package com.happyshiny.shoot.states;

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

class MenuState extends FlxState
{
    private var points : Array<FlxPoint> = null;
    private var player1 : Player;
    private var player2 : Player;

    public override function create():Void
    {
        super.create();

        points = new Array<FlxPoint>();

        player1 = new Player(0xffff0000, Player.SIDE_TOP);
        player2 = new Player(0xff0000ff, Player.SIDE_BOTTOM);

        // Keyboard events
        Lib.current.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);

        #if (web || desktop)
        FlxG.mouse.show();
        #end

        // SoundManager.playMusic("music");
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
            Lib.exit();
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

        // Check mouse/touch input
        #if mobile
        for (touch in FlxG.touchManager.touches)
        {
            if (touch.justPressed())
            {
                points.push(touch.getWorldPosition());
            }
        }
        #else
        if (FlxG.mouse.justPressed())
        {
            points.push(FlxG.mouse.getWorldPosition());
        }
        #end

        if (points.length > 0)
        {
            for(point in points)
            {

            }
            points = [];
        }
    }   
}
