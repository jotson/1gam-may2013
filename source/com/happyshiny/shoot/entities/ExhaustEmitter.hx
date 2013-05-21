package com.happyshiny.shoot.entities;

import com.happyshiny.util.SoundManager;
import org.flixel.addons.FlxEmitterExt;
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

class ExhaustEmitter extends FlxEmitter
{
    public static var PARTICLE_COUNT = 10;
    public static var LIFESPAN = 1.0;

    public function new()
    {
        super(0, 0, PARTICLE_COUNT);

        minParticleSpeed = new FlxPoint(0, 0);
        maxParticleSpeed = new FlxPoint(0, 0);
        minRotation = 0;
        maxRotation = 0;

        particleClass = ExhaustParticle;
        lifespan = LIFESPAN;
        width = 0;
        height = 0;

        for(i in 0...PARTICLE_COUNT)
        {
            var c = new ExhaustParticle();
            add(c);
        }
    }

    public function go():Void
    {
        super.start(false, LIFESPAN, 0.2);
    }
}

class ExhaustParticle extends FlxParticle
{
    public function new()
    {
        super();

        makeGraphic(Missile.WIDTH, 5, 0xffffffff);
        centerOffsets();

        visible = false;
    }

    public override function onEmit()
    {
        super.onEmit();

        revive();
    }

    public override function revive()
    {
        super.revive();

        alpha = 1.0;
        visible = true;

        FlxG.tween(this, { alpha: 0 }, ExhaustEmitter.LIFESPAN, { ease: Ease.quadIn });
    }
}
