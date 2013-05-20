package com.happyshiny.shoot;

import org.flixel.FlxG;
import org.flixel.FlxPoint;
import org.flixel.FlxButton;
import org.flixel.tweens.FlxTween;
import org.flixel.tweens.util.Ease;

class Button extends FlxButton
{
    public function new(X:Float, Y:Float, Graphic:String, width:Int, height:Int, OnClick:Void->Void = null)
    {
        super(X, Y, null, OnClick);

        label = null;

        loadGraphic(Graphic, true, true, width, height);
        x = x - width/2;
        y = y - height/2;

        // FlxG.tween(this, { y: y + 10 }, Math.random() * 0.3 + 0.4, { type: FlxTween.PINGPONG, ease: Ease.quadInOut });
    }
}
