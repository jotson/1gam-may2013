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
    public static var topPoints : Array<FlxPoint> = new Array<FlxPoint>();
    public static var bottomPoints : Array<FlxPoint> = new Array<FlxPoint>();
    public static var topPlayer : Player;
    public static var bottomPlayer : Player;
    public static var topGroup : FlxGroup;
    public static var bottomGroup : FlxGroup;
    public static var emitters : FlxGroup;

    public static var topWins : Bool = false;

    public static function resetState()
    {
        FlxG.state.bgColor = 0xff000000;

        topPlayer = new Player(Player.SIDE_TOP);
        bottomPlayer = new Player(Player.SIDE_BOTTOM);

        topGroup = new FlxGroup();
        bottomGroup = new FlxGroup();
        emitters = new FlxGroup();

        G.topGroup.add(topPlayer);
        G.bottomGroup.add(bottomPlayer);

        FlxG.state.add(topGroup);
        FlxG.state.add(bottomGroup);
        FlxG.state.add(emitters);

        topWins = false;
    }

    public static function update()
    {
        topPlayer.update();
        bottomPlayer.update();

        getInput();
        collisions();
    }

    public static function collisions()
    {
        FlxG.overlap(topGroup, bottomGroup, function(top, bottom) { objectHit(top, bottom); } );
    }

    public static function gameOver()
    {
        topWins = topPlayer.alive;
        FlxG.switchState(new GameoverState());
    }

    public static function objectHit(top : FlxObject, bottom : FlxObject) : Bool
    {
        if (FlxU.getClassName(top) == "com.happyshiny.shoot.entities.Missile")
        {
            if (top.velocity.y == 0)
            {
                topPlayer.hurt(0);
            }
            top.kill();
        }

        if (FlxU.getClassName(top) == "com.happyshiny.shoot.entities.Player")
        {
            top.hurt(0);
        }

        if (FlxU.getClassName(bottom) == "com.happyshiny.shoot.entities.Missile")
        {
            if (bottom.velocity.y == 0)
            {
                bottomPlayer.hurt(0);
            }
            bottom.kill();
        }

        if (FlxU.getClassName(bottom) == "com.happyshiny.shoot.entities.Player")
        {
            bottom.hurt(0);
        }

        FlxG.flash(0xffffffff, 0.1, null, true);

        return true;
    }

    public static function getInput()
    {
        // Check mouse/touch input
        for (touch in FlxG.touchManager.touches)
        {
            if (touch.pressed())
            {
                var p = touch.getWorldPosition();
                if (p.y < FlxG.height/2)
                {
                    topPoints.push(p);
                }
                else
                {
                    bottomPoints.push(p);
                }
            }
        }

        topPlayer.charge(topPoints);
        bottomPlayer.charge(bottomPoints);

        topPoints = [];
        bottomPoints = [];
    }
}
