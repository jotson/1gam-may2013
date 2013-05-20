package com.happyshiny.shoot.entities;

import org.flixel.FlxG;
import org.flixel.FlxPoint;
import org.flixel.FlxSprite;

class Player extends FlxSprite
{
    public var side : Int;
    public var energy : Float;
    public static var MAX_ENERGY : Float = 100;
    public static var MISSILE_ENERGY : Float = 25; // per shot
    public static var REGENERATE_RATE : Float = 25; // per second
    public static var SIDE_BOTTOM : Int = 1;
    public static var SIDE_TOP : Int = 2;
    public static var COLOR_TOP : Int = 0xffff0000;
    public static var COLOR_BOTTOM : Int = 0xff0000ff;

    public function new(side : Int)
    {
        super(0, 0);

        this.energy = 0;
        this.side = side;

        this.alpha = 0.75;

        x = 0;
        if (side == Player.SIDE_TOP)
        {
            makeGraphic(FlxG.width, 25, COLOR_TOP);
            y = 150;
        }
        else
        {
            makeGraphic(FlxG.width, 25, COLOR_BOTTOM);
            y = FlxG.height - this.height - 150;
        }
    }

    public override function update()
    {
        super.update();

        energy = energy + REGENERATE_RATE * FlxG.elapsed;
        if (energy >= MAX_ENERGY) energy = MAX_ENERGY;

        if (this.y + this.height < 0 || this.y > FlxG.height)
        {
            kill();
            G.gameOver();
        }
    }

    public override function hurt(damage : Float)
    {
        if (!this.alive) return;

        super.hurt(damage);

        FlxG.shake(0.01, 0.1);

        if (this.side == SIDE_TOP)
        {
            y = y - 10;
        }
        else
        {
            y = y + 10;
        }
    }

    public function fire(p : FlxPoint)
    {
        if (!this.alive) return;

        if (energy < MISSILE_ENERGY)
        {
            // TODO Bzzt
            return;
        }
        
        var m : Missile = null;
        if (side == Player.SIDE_TOP)
        {
            m = cast(G.topGroup.recycle(Missile), Missile);
        }
        else
        {
            m = cast(G.bottomGroup.recycle(Missile), Missile);
        }

        m.player = this;
        m.x = p.x;

        if (side == Player.SIDE_TOP)
        {
            m.y = this.y + this.height + 10;
        }
        else
        {
            m.y = this.y - m.height - 10;
        }

        m.revive();

        energy -= MISSILE_ENERGY;
    }
}
