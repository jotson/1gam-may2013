package com.happyshiny.shoot.entities;

import org.flixel.FlxG;
import org.flixel.FlxPoint;
import org.flixel.FlxSprite;

class Missile extends FlxSprite
{
    public static var SPEED = 1600;
    public var player : Player;
    private var launchTimer : Float;

    public function new()
    {
        super(-500, -500);
        this.width = 50;
        this.height = 2000;
    }

    public override function revive()
    {
        super.revive();

        var c : Int;
        if (player.side == Player.SIDE_TOP)
        {
            y = 0 - this.height;
            c = Player.COLOR_TOP;
        }
        else
        {
            y = FlxG.height;
            c = Player.COLOR_BOTTOM;
        }

        this.makeGraphic(Std.int(width), Std.int(height), c);
        this.velocity.y = 0;
        this.acceleration.y = 0;
        this.visible = false;

        launchTimer = 0.25;
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
                velocity.y = SPEED;
                angle = 180;
            }
            else
            {
                velocity.y = -SPEED;
                angle = 0;
            }
            visible = true;
        }

        if (velocity.y != 0 && !this.onScreen())
        {
            // TODO Score points
            kill();
        }
    }
}
