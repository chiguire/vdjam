package proto;

import flixel.addons.tile.FlxTilemapExt;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxColor;

/**
 * ...
 * @author Ciro Duran
 */
class Rostipollo extends FlxZSprite
{
	public var viga (default,set): Viga;

	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y, 0);
		loadGraphic(AssetPaths.pollobstaculo__png, false);
		allowCollisions = FlxObject.NONE;
		immovable = true;
	}
	
	public override function update(elapsed:Float)
	{
		super.update(elapsed);
		
		if (viga != null)
		{
			z = viga.z + 0.01;
			velocity.y = viga.velocity.y;
		}
		
		color = FlxColor.fromHSB(0, 0, 0.65 + z/(2*Viga.RADIUS) * 0.35);
	}
	
	public function set_viga(v:Viga)
	{
		y = v.y + v.height / 2 - this.height / 2 - 10;
		return viga = v;
	}
}