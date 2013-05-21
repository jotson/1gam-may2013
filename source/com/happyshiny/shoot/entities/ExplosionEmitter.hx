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

class ExplosionEmitter extends FlxEmitterExt
{
    public static var PARTICLE_COUNT = 40;
    public static var LIFESPAN = 3.0;

    public function new()
    {
        super(-500, -500, PARTICLE_COUNT);

        setMotion(0, 25, LIFESPAN, 360, 225, LIFESPAN);
        particleDrag.x = 300;
        particleDrag.y = 300;

        for(i in 0...PARTICLE_COUNT)
        {
            var c = new ExplosionParticle();
            add(c);
        }
    }

    public function go():Void
    {
        super.start(true, LIFESPAN, 0);
    }
}

class ExplosionParticle extends FlxParticle
{
    public function new()
    {
        super();

        loadGraphic("assets/images/explosion-particle.png");
        centerOffsets();
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
        visible = true;

        FlxG.tween(this, { alpha: 0 }, ExhaustEmitter.LIFESPAN, { ease: Ease.quadIn });
    }
}
