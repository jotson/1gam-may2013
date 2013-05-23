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

class MenuState extends FlxState
{
    public override function create():Void
    {
        super.create();

        var top = new FlxSprite(0, 0);
        top.makeGraphic(FlxG.width, Std.int(FlxG.height/2), Player.COLOR_TOP);
        add(top);

        var bottom = new FlxSprite(0, FlxG.height/2);
        bottom.makeGraphic(FlxG.width, Std.int(FlxG.height/2), Player.COLOR_BOTTOM);
        add(bottom);

        // Top
        var t : FlxText = new FlxText(0, FlxG.height/16 * 1, FlxG.width, "DUEL!", 56, true);
        t.alignment = "center";
        add(t);

        t = new FlxText(0, FlxG.height/16 * 3, FlxG.width, "By John Watson", 20, true);
        t.alignment = "center";
        add(t);

        t = new FlxText(0, FlxG.height/16 * 4, FlxG.width, "flagrantdisregard.com", 20, true);
        t.alignment = "center";
        add(t);

        t = new FlxText(0, FlxG.height/16 * 5, FlxG.width, "#1GAM", 20, true);
        t.alignment = "center";
        add(t);

        // Bottom
        t = new FlxText(0, FlxG.height/16 * 15, FlxG.width, "DUEL!", 56, true);
        #if mobile
        t.y -= Std.int(t.height);
        #end
        t.alignment = "center";
        t.angle = 180;
        add(t);

        t = new FlxText(0, FlxG.height/16 * 13, FlxG.width, "By John Watson", 20, true);
        #if mobile
        t.y -= Std.int(t.height);
        #end
        t.alignment = "center";
        t.angle = 180;
        add(t);

        t = new FlxText(0, FlxG.height/16 * 12, FlxG.width, "flagrantdisregard.com", 20, true);
        #if mobile
        t.y -= Std.int(t.height);
        #end
        t.alignment = "center";
        t.angle = 180;
        add(t);

        t = new FlxText(0, FlxG.height/16 * 11, FlxG.width, "#1GAM", 20, true);
        #if mobile
        t.y -= Std.int(t.height);
        #end
        t.alignment = "center";
        t.angle = 180;
        add(t);

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
