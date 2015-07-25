package proto;

import flixel.util.FlxColorUtil;

/**
 * ...
 * @author Ciro Duran
 */
class Pollo extends FlxZSprite
{
	public var is_standing_on_viga : Bool;
	public var standing_on_viga_counter : Int = 0;

	public function new(x:Float=0, y:Float=0, z:Float=0, ?SimpleGraphic:Dynamic) 
	{
		super(x, y, z, SimpleGraphic);
		is_standing_on_viga = false;
	}
	
	public override function update()
	{
		super.update();
		
		color = FlxColorUtil.HSVtoARGB(0, 0, 0.65 + z/(2*Viga.RADIUS) * 0.35);
	}
}