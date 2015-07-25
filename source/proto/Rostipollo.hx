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
	public var tilemap : FlxTilemapExt;
	public var viga : Viga;

	public function new(X:Float=0, Y:Float=0, ?SimpleGraphic:Dynamic) 
	{
		super(X, Y, 0, SimpleGraphic);
		makeGraphic(105, 70, FlxColor.BROWN);
		allowCollisions = FlxObject.NONE;
		immovable = true;
		tilemap = new FlxTilemapExt();
		tilemap.loadMap("1,5,2\n3,5,4", AssetPaths.tilesetslopenontransparent__png, 35, 35);
		tilemap.setSlopes([1], [2], [3], [4]);
		tilemap.immovable = true;
	}
	
	public override function update()
	{
		super.update();
		
		if (viga != null)
		{
			z = viga.z + 0.01;
			y = viga.y + viga.height / 2 - this.height / 2;
			tilemap.y = y;
		}
		
		color = FlxColorUtil.HSVtoARGB(0, 0, 0.65 + z/(2*Viga.RADIUS) * 0.35);
	}
}