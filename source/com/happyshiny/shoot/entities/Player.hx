package com.happyshiny.shoot.entities;

import org.flixel.FlxG;
import org.flixel.FlxPoint;

class Player
{
    public var color : Int;
    public var side : Int;
    public var energy : Float;
    public static var MAX_ENERGY : Float = 75;
    public static var MISSILE_ENERGY : Float = 25; // per shot
    public static var REGENERATE_RATE : Float = 5; // per second
    public static var SIDE_BOTTOM : Int = 1;
    public static var SIDE_TOP : Int = 2;

    public function new(color : Int, side : Int)
    {
        this.energy = MAX_ENERGY;
        this.color = color;
        this.side = side;
    }

    public function update()
    {
        energy = energy + REGENERATE_RATE * FlxG.elapsed;
        if (energy >= MAX_ENERGY) energy = MAX_ENERGY;
    }

    public function fire(p : FlxPoint)
    {
        // TODO Fire missile from this point
        
        var m : Missile = cast(FlxG.state.recycle(Missile), Missile);
        m.player = this;
        m.x = p.x;
        if (side == Player.SIDE_TOP)
        {
            m.y = 10;
        }
        else
        {
            m.y = FlxG.camera.height - 10;
        }
    }
}
