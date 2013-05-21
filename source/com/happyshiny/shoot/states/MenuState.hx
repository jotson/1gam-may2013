package com.happyshiny.shoot.states;

import com.happyshiny.shoot.Button;
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
    public override function create():Void
    {
        super.create();

        // Start button
        add(new Button(FlxG.width/2, FlxG.height/2 - 32, 'assets/images/start-button.png', 128, 160, function() { startGame(); }));

        // Keyboard events
        Lib.current.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);

        #if (web || desktop)
        FlxG.mouse.show();
        #end

        // SoundManager.playMusic("music");
    }
    
    public function startGame()
    {
        FlxG.switchState(new GameState());
        destroy();
    }

    public function onKeyUp(e : KeyboardEvent):Void
    {
        // Space bar
        if (e.keyCode == 32)
        {
            e.stopImmediatePropagation();
            startGame();
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
    }   
}
