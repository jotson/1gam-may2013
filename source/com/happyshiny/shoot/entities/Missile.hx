package com.happyshiny.shoot.entities;

import org.flixel.FlxG;
import org.flixel.FlxPoint;
import org.flixel.FlxSprite;

class Missile extends FlxSprite
{
    public static var ACCELERATION = 300;
    public var player : Player;
    private var launchTimer : Float;

    public function new()
    {
        super(-500, -500);
        this.width = 10;
        this.height = 25;
    }

    public override function revive()
    {
        super.revive();

        var c : Int = Player.COLOR_BOTTOM;
        if (player.side == Player.SIDE_TOP)
        {
            c = Player.COLOR_TOP;
        }

        this.makeGraphic(Std.int(width), Std.int(height), c);
        this.velocity.y = 0;
        this.acceleration.y = 0;

        launchTimer = 2;
    }

    public override function update()
    {
        super.update();

        if (player == null) return;

        launchTimer -= FlxG.elapsed;
        if (launchTimer <= 0 && velocity.y == 0 && acceleration.y == 0)
        {
            if (player.side == Player.SIDE_TOP)
            {
                acceleration.y = ACCELERATION;
                angle = 180;
            }
            else
            {
                acceleration.y = -ACCELERATION;
                angle = 0;
            }
        }

        if (acceleration.y != 0 && !this.onScreen())
        {
            // TODO Score points
            kill();
        }
    }
}
