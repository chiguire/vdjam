package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;

/**
 * ...
 * @author Ciro Duran
 */
class CreditsState extends FlxState
{
	override public function create():Void
	{
		var spr = new FlxSprite(0, 0, AssetPaths.credits__png);
		add(spr);
		
		var txt = new FlxText(103, 30, 400, "Ciro Durán", 24);
		add(txt);
		
		txt = new FlxText(103, 55, 400, "Programming", 12);
		add(txt);
		
		txt = new FlxText(103, 69, 400, "http://www.ciroduran.com\nTwitter: @chiguire", 12);
		add(txt);
		
		txt = new FlxText(103, 110, 400, "Héctor Vargas", 24);
		add(txt);
		
		txt = new FlxText(103, 135, 400, "Graphics and Music", 12);
		add(txt);
		
		txt = new FlxText(103, 149, 400, "https://www.facebook.com/BahaComics\nTwitter: @Baha_Z", 12);
		add(txt);
		
		txt = new FlxText(320, 30, 300, "Hector: para Bella. Always.\nCiro: Siempre .Y. <3", 12);
		add(txt);
		
		txt = new FlxText(320, 70, 300, "Hecho para el Venezuela Duel Jam, por el equipo Johnnie Walker y Cocuy.\nBarquisimeto, Edo. Lara, Venezuela. Sutton, Surrey, Reino Unido. Julio 2015.", 12);
		add(txt);
	}
	
	override public function destroy():Void
	{
		super.destroy();
	}
	
	override public function update()
	{
		super.update();
		
		if (FlxG.mouse.justPressed || FlxG.keys.getIsDown().length > 0)
		{
			return_handler();
		}
	}
	
	public function return_handler()
	{
		FlxG.switchState(new MenuState());
	}
}