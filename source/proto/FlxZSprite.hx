package proto;
import flixel.FlxSprite;
import flixel.FlxBasic;
import flixel.util.FlxSort;

/**
 * ...
 * @author Ciro Duran
 */
class FlxZSprite extends FlxSprite
{
	public var z : Float;
	
	public function new(x:Float = 0, y:Float = 0, z:Float = 0, ?SimpleGraphic:Dynamic) 
	{
		super(x, y, SimpleGraphic);
		this.z = z;
	}
	
	public static inline function byZ(Order:Int, Obj1:FlxBasic, Obj2:FlxBasic):Int
	{
		return FlxSort.byValues(Order, cast(Obj1, FlxZSprite).z, cast(Obj2, FlxZSprite).z);
	}
}