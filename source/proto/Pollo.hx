package proto;

import flixel.FlxObject;
import flixel.util.FlxColorUtil;

/**
 * ...
 * @author Ciro Duran
 */
class Pollo extends FlxZSprite
{
	public var is_standing_on_viga : Bool;
	public var standing_on_viga_counter : Int = 0;
	public var pressed_left : Bool = false;
	public var pressed_right : Bool = false;

	public function new(x:Float=0, y:Float=0, z:Float=0) 
	{
		super(x, y, z);
		is_standing_on_viga = false;
		loadGraphic(AssetPaths.clotilde_tira__png, true, 77, 101);
		animation.add("idle", [0, 1, 2], 5, true);
		animation.add("run", [for (i in 3...28) i], 30, true);
		animation.add("jump", [28, 29, 30, 31, 32], 3, false);
		animation.play("idle");
		facing = FlxObject.LEFT;
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
	}
	
	public override function update()
	{
		super.update();
		
		if (pressed_right)
		{
			facing = FlxObject.RIGHT;
			animation.play("run");
		}
		else if (pressed_left)
		{
			facing = FlxObject.LEFT;
			animation.play("run");
		}
		else if (Math.abs(velocity.y) < 10)
		{
			animation.play("idle");
		}
		
		color = FlxColorUtil.HSVtoARGB(0, 0, 0.65 + z/(2*Viga.RADIUS) * 0.35);
	}
	
	public function jump()
	{
		animation.play("jump", true);
	}
}