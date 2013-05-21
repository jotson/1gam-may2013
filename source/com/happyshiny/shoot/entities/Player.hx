package com.happyshiny.shoot.entities;

import com.happyshiny.shoot.entities.Particles.ChargeEmitter;
import nme.Lib;
import org.flixel.FlxG;
import org.flixel.FlxPoint;
import org.flixel.FlxSprite;
import org.flixel.FlxU;

class Player extends FlxSprite
{
    public var side : Int;
    public var energy : Float;
    public var slots : Array<ChargeEmitter>;

    public static var MAX_SLOTS : Int = 2;
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

        slots = new Array<ChargeEmitter>();

        this.energy = 0;
        this.side = side;

        this.alpha = 0.75;

        x = 0;
        if (side == Player.SIDE_TOP)
        {
            makeGraphic(FlxG.width, 150, COLOR_TOP);
            y = 0;
        }
        else
        {
            makeGraphic(FlxG.width, 150, COLOR_BOTTOM);
            y = FlxG.height - this.height;
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

    public function charge(points : Array<FlxPoint>)
    {
        if (!this.alive) return;

        if (points.length > MAX_SLOTS) points = points.splice(0, MAX_SLOTS);

        for(m in slots)
        {
            m.assigned = false;
        }

        for(p in points)
        {
            // Assign the closest ChargeEmitter to each touch
            var distance = Lib.MAX_FLOAT_VALUE;
            var closest : ChargeEmitter = null;
            for(m in slots)
            {
                if (m.assigned) continue;
                var d = FlxU.getDistance(p, new FlxPoint(m.x, m.y));
                if (d < distance)
                {
                    distance = d;
                    closest = m;
                }
            }
            if (closest == null)
            {
                closest = cast(G.emitters.recycle(ChargeEmitter), ChargeEmitter);
                closest.revive();
                closest.go();
                slots.push(closest);
            }
            closest.x = p.x;
            closest.y = p.y;
            closest.assigned = true;
        }

        for (m in slots)
        {
            if (!m.assigned)
            {
                if (m.energy == ChargeEmitter.MAX_ENERGY)
                {
                    fire(new FlxPoint(m.x, m.y));
                }
                m.stop();
                slots.remove(m);
            }
        }
    }

    public function fire(p : FlxPoint)
    {
        if (!this.alive) return;

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
        m.revive();
    }
}
