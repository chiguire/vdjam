package proto;

import flixel.addons.tile.FlxTilemapExt;
import flixel.FlxSprite;
import flixel.group.FlxTypedGroup;
import flixel.util.FlxColor;
import flixel.util.FlxAngle;
import flixel.FlxObject;
import flixel.util.FlxPoint;
import flixel.util.FlxSpriteUtil;
import flixel.FlxG;
import flixel.util.FlxColorUtil;

/**
 * ...
 * @author Ciro Duran
 */
class Viga extends FlxZSprite
{
	public var rostipollos : FlxTypedGroup<Rostipollo>;
	public var base_y : Float;
	public var z_angle(get, set) : Float;
	private var _z_angle : Float;

	public static var RADIUS : Float = 120;
	
	public var dropped : Bool = false;
	
	public function new(base_y:Float, i:Int) 
	{
		super(0, 0, 0);
		this.base_y = base_y;
		makeGraphic(FlxG.width*3, 10, FlxColor.GRAY, true, "viga"+i);
		allowCollisions = FlxObject.UP;
		immovable = true;
		
		rostipollos = new FlxTypedGroup<Rostipollo>();
	}
	
	public function get_z_angle()
	{
		return _z_angle;
	}
	
	public function set_z_angle(value_degrees:Float)
	{
		var v = FlxAngle.asRadians(value_degrees + 90);
		y = base_y + RADIUS * Math.sin(v);
		z = RADIUS * Math.sin(v);
		calculate_velocity(value_degrees);
		return _z_angle = value_degrees;
	}
	
	public override function update()
	{
		super.update();
		
		if (!dropped)
		{
			_z_angle += 1;
			if (_z_angle > 360) _z_angle -= 360;
			
			calculate_velocity(z_angle);
			z = RADIUS * Math.cos(FlxAngle.asRadians(z_angle+90));
		}
		
		color = FlxColorUtil.HSVtoARGB(0, 0, 0.65 + z/(2*RADIUS) * 0.35);
	}
	
	
	private function calculate_velocity(value:Float)
	{
		var v = FlxAngle.asRadians(value+90);
		velocity.y = RADIUS * Math.cos(v);
	}
	
	public function drop()
	{
		dropped = true;
		acceleration.y = 240;
	}
}