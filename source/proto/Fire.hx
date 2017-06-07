package proto;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.addons.effects.chainable.FlxWaveEffect;
import flixel.group.FlxGroup;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

/**
 * ...
 * @author Ciro Duran
 */
class Fire extends FlxGroup
{
	public var fire_effect : FlxWaveEffect;
	public var fire1 : FlxSprite; //: FlxEffectSprite;
	public var fire2 : FlxSprite; //: FlxEffectSprite;
	public var fire3 : FlxSprite; //: FlxEffectSprite;
	public var fire4 : FlxSprite; //: FlxEffectSprite;

	public function new() 
	{
		super(4);
		//fire_effect = new FlxWaveEffect(FlxWaveMode.ALL, 10, -1, 5);
		var f = new FlxSprite(0, FlxG.height - 260, AssetPaths.fire__png);
		fire1 = f; // = new FlxEffectSprite(f, [fire_effect]);
		fire1.alpha = 0.5;
		fire1.scrollFactor.x = 1.25;
		add(fire1);
		FlxTween.tween(fire1, {y: FlxG.height - 250}, 1, { type: FlxTween.PINGPONG, ease: FlxEase.cubeInOut });
		
		f = new FlxSprite(FlxG.width, FlxG.height - 260, AssetPaths.fire__png);
		fire2 = f; // = new FlxEffectSprite(f, [fire_effect]);
		fire2.alpha = 0.5;
		fire2.scrollFactor.x = 1.25;
		add(fire2);
		FlxTween.tween(fire2, {y: FlxG.height - 250}, 1, { type: FlxTween.PINGPONG, ease: FlxEase.cubeInOut });
		
		f = new FlxSprite(FlxG.width*2, FlxG.height - 260, AssetPaths.fire__png);
		fire3 = f; // = new FlxEffectSprite(f, [fire_effect]);
		fire3.alpha = 0.5;
		fire3.scrollFactor.x = 1.25;
		add(fire3);
		FlxTween.tween(fire3, {y: FlxG.height - 250}, 1, { type: FlxTween.PINGPONG, ease: FlxEase.cubeInOut });
		
		f = new FlxSprite(FlxG.width*3, FlxG.height - 260, AssetPaths.fire__png);
		fire4 = f; // = new FlxEffectSprite(f, [fire_effect]);
		fire4.alpha = 0.5;
		fire4.scrollFactor.x = 1.25;
		add(fire4);
		FlxTween.tween(fire4, {y: FlxG.height - 250}, 1, { type: FlxTween.PINGPONG, ease: FlxEase.cubeInOut });
	}
	
	
	
}