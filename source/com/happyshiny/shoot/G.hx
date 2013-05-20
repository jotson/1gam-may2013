package com.happyshiny.shoot;

import com.happyshiny.shoot.entities.Player;
import com.happyshiny.shoot.states.GameoverState;
import nme.Assets;
import nme.geom.Rectangle;
import nme.geom.Point;
import nme.geom.ColorTransform;
import nme.display.BlendMode;
import nme.geom.Matrix;
import nme.display.BitmapData;
import nme.display.BitmapInt32;
import nme.net.SharedObject;
import nme.Lib;
import nme.ui.Mouse;
import nme.events.KeyboardEvent;
import org.flixel.FlxTimer;
import org.flixel.system.input.FlxTouchManager;
import org.flixel.FlxButton;
import org.flixel.FlxG;
import org.flixel.FlxPath;
import org.flixel.FlxRect;
import org.flixel.FlxPoint;
import org.flixel.FlxSave;
import org.flixel.FlxSprite;
import org.flixel.FlxObject;
import org.flixel.FlxState;
import org.flixel.FlxGroup;
import org.flixel.FlxTypedGroup;
import org.flixel.FlxText;
import org.flixel.FlxCamera;
import org.flixel.FlxU;
import org.flixel.FlxTilemap;
import org.flixel.tweens.FlxTween;
import org.flixel.tweens.misc.Alarm;
import org.flixel.tweens.util.Ease;
import org.flixel.plugin.photonstorm.FlxBar;
import org.flixel.plugin.photonstorm.FlxCollision;

import com.happyshiny.util.SoundManager;

class G
{
    public static var points : Array<FlxPoint> = new Array<FlxPoint>();
    public static var playerTop : Player;
    public static var playerBottom : Player;
    public static var topGroup : FlxGroup;
    public static var bottomGroup : FlxGroup;

    public static var topEnergyBar : FlxBar;
    public static var bottomEnergyBar : FlxBar;

    public static var topWins : Bool = false;

    public static function resetState()
    {
        FlxG.state.bgColor = 0xff000000;

        playerTop = new Player(Player.SIDE_TOP);
        playerBottom = new Player(Player.SIDE_BOTTOM);

        topGroup = new FlxGroup();
        bottomGroup = new FlxGroup();

        G.topGroup.add(playerTop);
        G.bottomGroup.add(playerBottom);

        FlxG.state.add(topGroup);
        FlxG.state.add(bottomGroup);

        topEnergyBar = new FlxBar(10, 10, FlxBar.FILL_RIGHT_TO_LEFT, FlxG.width - 20, 10);
        topEnergyBar.setRange(0, Player.MAX_ENERGY);
        topEnergyBar.setParent(playerTop, "energy");
        topEnergyBar.createFilledBar(0xff330000, 0xffff0000, true, 0xff000000);
        FlxG.state.add(topEnergyBar);

        bottomEnergyBar = new FlxBar(10, FlxG.height - 20, FlxBar.FILL_LEFT_TO_RIGHT, FlxG.width - 20, 10);
        bottomEnergyBar.setRange(0, Player.MAX_ENERGY);
        bottomEnergyBar.setParent(playerBottom, "energy");
        bottomEnergyBar.createFilledBar(0xff000033, 0xff0000ff, true, 0xff000000);
        FlxG.state.add(bottomEnergyBar);

        topWins = false;
    }

    public static function update()
    {
        playerTop.update();
        playerBottom.update();

        getInput();
        collisions();
    }

    public static function collisions()
    {
        FlxG.overlap(topGroup, bottomGroup, function(top, bottom) { objectHit(top, bottom); } );
    }

    public static function gameOver()
    {
        topWins = playerTop.alive;
        FlxG.switchState(new GameoverState());
    }

    public static function objectHit(top : FlxObject, bottom : FlxObject) : Bool
    {
        if (FlxU.getClassName(top) == "com.happyshiny.shoot.entities.Missile")
        {
            if (top.acceleration.y == 0)
            {
                playerTop.hurt(0);
            }
            top.kill();
        }

        if (FlxU.getClassName(top) == "com.happyshiny.shoot.entities.Player")
        {
            top.hurt(0);
        }

        if (FlxU.getClassName(bottom) == "com.happyshiny.shoot.entities.Missile")
        {
            if (bottom.acceleration.y == 0)
            {
                playerBottom.hurt(0);
            }
            bottom.kill();
        }

        if (FlxU.getClassName(bottom) == "com.happyshiny.shoot.entities.Player")
        {
            bottom.hurt(0);
        }

        return true;
    }

    public static function getInput()
    {
        // Check mouse/touch input
        #if mobile
        for (touch in FlxG.touchManager.touches)
        {
            if (touch.pressed())
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
                if (point.y > FlxG.height/2)
                {
                    // Bottom player
                    playerBottom.fire(point);
                }
                else
                {
                    playerTop.fire(point);
                }
            }
            points = [];
        }
    }
}
