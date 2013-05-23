package com.happyshiny.duel.entities;

import com.happyshiny.duel.entities.ExhaustEmitter;
import com.happyshiny.duel.entities.ExplosionEmitter;
import com.happyshiny.util.SoundManager;
import org.flixel.FlxG;
import org.flixel.FlxPoint;
import org.flixel.FlxSprite;

class Missile extends FlxSprite
{
    public static var WIDTH = 25;

    public static var SPEED = 60;
    public var player : Player;
    private var launchTimer : Float;

    private var exhaustEmitter : ExhaustEmitter;
    private var explosionEmitter : ExplosionEmitter;

    public function new()
    {
        super(-500, -500);
        this.width = WIDTH;
        this.height = 25;

        exhaustEmitter = new ExhaustEmitter();
        exhaustEmitter.go();

        FlxG.state.add(exhaustEmitter);

        explosionEmitter = new ExplosionEmitter();
        FlxG.state.add(explosionEmitter);
    }

    public override function kill()
    {
        super.kill();

        exhaustEmitter.x = -500;
        exhaustEmitter.y = -500;

        explosionEmitter.x = this.x;
        explosionEmitter.y = this.y;
        for(m in explosionEmitter.members)
        {
            if (player.side == Player.SIDE_TOP)
            {
                m.color = Player.COLOR_TOP;
            }
            else
            {
                m.color = Player.COLOR_BOTTOM;
            }
        }
        explosionEmitter.go();
        
        SoundManager.play("missile-hit");
    }

    public override function revive()
    {
        super.revive();

        var c : Int;
        if (player.side == Player.SIDE_TOP)
        {
            y = player.y + player.height + 1;
            c = Player.COLOR_TOP;
        }
        else
        {
            y = player.y - this.height - 1;
            c = Player.COLOR_BOTTOM;
        }

        this.makeGraphic(Std.int(width), Std.int(height), c);
        this.velocity.y = 0;
        this.acceleration.y = 0;
        this.visible = false;

        launchTimer = 0;
    }

    public override function update()
    {
        super.update();

        if (player == null) return;

        exhaustEmitter.x = this.x + this.width/2;

        if (player.side == Player.SIDE_TOP)
        {
            exhaustEmitter.y = this.y;
        }
        else
        {
            exhaustEmitter.y = this.y + this.height;
        }

        launchTimer -= FlxG.elapsed;
        if (launchTimer <= 0 && velocity.y == 0)
        {
            SoundManager.play("launch");

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
