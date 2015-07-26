package proto;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.effects.FlxWaveSprite;
import flixel.group.FlxGroup;

/**
 * ...
 * @author Ciro Duran
 */
class Fire extends FlxGroup
{
	public var fire1 : FlxWaveSprite;
	public var fire2 : FlxWaveSprite;
	public var fire3 : FlxWaveSprite;
	public var fire4 : FlxWaveSprite;

	public function new() 
	{
		super(4);
		var f = new FlxSprite(0, FlxG.height - 260, AssetPaths.fire__png);
		fire1 = new FlxWaveSprite(f, WaveMode.ALL, 10, -1, 5);
		fire1.alpha = 0.5;
		fire1.scrollFactor.x = 1.25;
		add(fire1);
		
		f = new FlxSprite(FlxG.width, FlxG.height - 260, AssetPaths.fire__png);
		fire2 = new FlxWaveSprite(f, WaveMode.ALL, 10, -1, 5);
		fire2.alpha = 0.5;
		fire2.scrollFactor.x = 1.25;
		add(fire2);
		
		f = new FlxSprite(FlxG.width*2, FlxG.height - 260, AssetPaths.fire__png);
		fire3 = new FlxWaveSprite(f, WaveMode.ALL, 10, -1, 5);
		fire3.alpha = 0.5;
		fire3.scrollFactor.x = 1.25;
		add(fire3);
		
		f = new FlxSprite(FlxG.width*3, FlxG.height - 260, AssetPaths.fire__png);
		fire4 = new FlxWaveSprite(f, WaveMode.ALL, 10, -1, 5);
		fire4.alpha = 0.5;
		fire4.scrollFactor.x = 1.25;
		add(fire4);
	}
	
	
	
}