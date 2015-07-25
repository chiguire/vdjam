package proto;

import flixel.addons.tile.FlxTilemapExt;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxColorUtil;

/**
 * ...
 * @author Ciro Duran
 */
class Rostipollo extends FlxZSprite
{
	public var viga (default,set): Viga;

	public function new(X:Float=0, Y:Float=0, ?SimpleGraphic:Dynamic) 
	{
		super(X, Y, 0, SimpleGraphic);
		makeGraphic(105, 70, FlxColor.BROWN);
		allowCollisions = FlxObject.ANY;
		immovable = true;
	}
	
	public override function update()
	{
		super.update();
		
		if (viga != null)
		{
			z = viga.z + 0.01;
			velocity.y = viga.velocity.y;
		}
		
		color = FlxColorUtil.HSVtoARGB(0, 0, 0.65 + z/(2*Viga.RADIUS) * 0.35);
	}
	
	public function set_viga(v:Viga)
	{
		y = v.y + v.height / 2 - this.height / 2;
		return viga = v;
	}
}