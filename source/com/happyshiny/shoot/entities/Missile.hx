package com.happyshiny.shoot.entities;

import org.flixel.FlxPoint;
import org.flixel.FlxSprite;

class Missile extends FlxSprite
{
    public static var ACCELERATION = 100;
    private var launchTimer : Float;
    private var player : Player;

    public function new()
    {
        super.new(-500, -500);
    }

    public override function revive()
    {
        super.revive();

        this.energy = MAX_ENERGY;
        this.angle = 0;
        this.makeGraphic(5, 5, color);
        this.velocity.y = 0;
        this.acceleration.y = 0;
        this.player = null;

        launchTimer = 3;
    }

    public override function update()
    {
        super.update();

        if (player == null) return;

        launchTimer -= FlxG.elapsed;
        if (launchTimer <= 0 && velocity.y = 0 && acceleration.y = 0)
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
