package com.happyshiny.duel.states;

import com.happyshiny.duel.Button;
import com.happyshiny.duel.entities.Player;
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

class GameoverState extends FlxState
{
    public override function create():Void
    {
        super.create();

        var t : FlxText = new FlxText(0, FlxG.height/2 - 200, FlxG.width, "X", 56, true);
        t.alignment = "center";
        if (G.topWins)
        {
            t.text = "YOU LOSE!";
            this.bgColor = Player.COLOR_TOP;
        }
        else
        {
            t.text = "YOU WIN!";
            this.bgColor = Player.COLOR_BOTTOM;
        }
        add(t);
        t.flicker(0.5);

        t = new FlxText(0, FlxG.height/2 + 200, FlxG.width, "X", 56, true);
        #if mobile
        t.y -= Std.int(t.height);
        #end
        t.angle = 180;
        t.alignment = "center";
        if (G.topWins)
        {
            t.text = "YOU WIN!";
        }
        else
        {
            t.text = "YOU LOSE!";
        }
        add(t);
        t.flicker(0.5);

        // Start button
        add(new Button(FlxG.width/2, FlxG.height/2, 'assets/images/start-button.png', 128, 128, function() { SoundManager.play("button"); startGame(); }));

        // Keyboard events
        Lib.current.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);

        #if (web || desktop)
        FlxG.mouse.show();
        #end

        SoundManager.playMusic("music");
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
    }   
}
