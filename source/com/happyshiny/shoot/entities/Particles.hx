package com.happyshiny.shoot.entities;

import com.happyshiny.util.SoundManager;
import org.flixel.FlxSprite;
import org.flixel.FlxEmitter;
import org.flixel.FlxState;
import org.flixel.FlxG;
import org.flixel.FlxObject;
import org.flixel.FlxParticle;
import org.flixel.FlxPoint;
import org.flixel.tweens.FlxTween;
import org.flixel.tweens.util.Ease;
import nme.Lib;

class ChargeParticle extends FlxParticle
{
    public var parent : ChargeEmitter = null;
    private var originX : Float = 0;
    private var originY : Float = 0;

    public function new()
    {
        super();

        makeGraphic(5, 5, 0xffffffff);
        centerOffsets();

        x = -500;
        y = -500;
    }

    public override function onEmit()
    {
        super.onEmit();

        revive();
    }

    public override function revive()
    {
        super.revive();

        alpha = 1;
        color = 0xffffffff;
        if (parent.energy == ChargeEmitter.MAX_ENERGY)
        {
            color = 0xff00ff00;
        }
        
        var radius = 50;
        var angle = Math.random() * Math.PI * 2;

        x = parent.x + Math.cos(angle) * radius;
        y = parent.y + Math.sin(angle) * radius;

        FlxG.tween(this, { x: parent.x, y: parent.y, alpha: 0 }, ChargeEmitter.LIFESPAN, { ease: Ease.quadIn });
    }

    public override function update()
    {
        super.update();
    }
}

class ChargeEmitter extends FlxEmitter
{
    public static var PARTICLE_COUNT = 50;
    public static var LIFESPAN = 0.25;

    public static var MAX_ENERGY = 100;
    public static var CHARGE_RATE = 100; // energy per second

    public var assigned : Bool = false;
    public var energy : Float = 0;

    public function new(x : Float = 0, y : Float = 0)
    {
        super(x, y, PARTICLE_COUNT);

        minParticleSpeed = new FlxPoint(0, 0);
        maxParticleSpeed = new FlxPoint(0, 0);
        minRotation = 0;
        maxRotation = 0;

        particleClass = ChargeParticle;
        lifespan = LIFESPAN;
        width = 1;
        height = 1;

        for(i in 0...PARTICLE_COUNT)
        {
            var c = new ChargeParticle();
            c.parent = this;
            add(c);
        }
    }

    public override function update()
    {
        super.update();

        energy += CHARGE_RATE * FlxG.elapsed;
        if (energy > MAX_ENERGY) energy = MAX_ENERGY;
    }
    public override function revive()
    {
        super.revive();
        energy = 0;
    }

    public function go():Void
    {
        super.start(false, LIFESPAN, 0.02);
    }

    public function stop():Void
    {
        super.start(true, LIFESPAN, 0);
    }
}
