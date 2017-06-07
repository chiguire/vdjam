package;

import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.addons.effects.chainable.FlxWaveEffect;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.tweens.motion.QuadMotion;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	public var bg_sprite : FlxSprite;
	public var bg_fire_effect : FlxWaveEffect;
	public var bg_fire1 : FlxSprite; // : FlxEffectSprite;
	public var bg_fire2 : FlxSprite; //: FlxEffectSprite;
	public var chef : FlxSprite;
	public var midground1 : FlxSprite;
	public var midground2 : FlxSprite;
	public var chicken : FlxSprite;
	public var fg_fire1 : FlxSprite; //: FlxEffectSprite;
	public var fg_fire2 : FlxSprite; //: FlxEffectSprite;
	
	public var txt : FlxText;
	public var txt2 : FlxText;
	public var button : FlxButton;
	public var button2 : FlxButton;
	public var button3 : FlxButton;
	
	private var anim_ix : Int;
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		
		bg_sprite = new FlxSprite(0, 0, AssetPaths.title_background_mate__png);
		add(bg_sprite);
		
		var spr = new FlxSprite(0, 0, AssetPaths.title_background_flames__png);
		bg_fire_effect = new FlxWaveEffect(FlxWaveMode.ALL, 5, -1, 5);
		bg_fire1 = spr;// new FlxEffectSprite(spr, [bg_fire_effect]);
		
		add(bg_fire1);
		FlxTween.tween(bg_fire1, {x: FlxG.width}, 45, { type: FlxTween.LOOPING });
		FlxTween.tween(bg_fire1, {y: 10}, 0.5, { type: FlxTween.PINGPONG, ease: FlxEase.cubeInOut });
		//FlxTween.linearMotion(bg_fire1, 0, 0, FlxG.width, 0, 45, true, { type: FlxTween.LOOPING } );
		
		spr = new FlxSprite(-FlxG.width, 0, AssetPaths.title_background_flames__png);
		bg_fire2 = spr;// new FlxEffectSprite(spr, [bg_fire_effect]);
		add(bg_fire2);
		FlxTween.tween(bg_fire2, {x: 0}, 45, { type: FlxTween.LOOPING });
		FlxTween.tween(bg_fire2, {y: 10}, 0.5, { type: FlxTween.PINGPONG, ease: FlxEase.cubeInOut });
		//FlxTween.linearMotion(bg_fire2, -FlxG.width, 0, 0, 0, 45, true, { type: FlxTween.LOOPING } );
		
		chef = new FlxSprite(0, 0, AssetPaths.title_chef__png);
		add(chef);
		FlxTween.linearMotion(chef, 0, 0, 0, -20, 1, true, { type: FlxTween.PINGPONG, ease: FlxEase.quadInOut } );
		
		midground1 = new FlxSprite(0, 0, AssetPaths.title_midground__png);
		add(midground1);
		FlxTween.linearMotion(midground1, 0, 0, FlxG.width, 0, 30, true, { type: FlxTween.LOOPING } );
		
		midground2 = new FlxSprite(-FlxG.width, 0, AssetPaths.title_midground__png);
		add(midground2);
		FlxTween.linearMotion(midground2, -FlxG.width, 0, 0, 0, 30, true, { type: FlxTween.LOOPING } );
		
		chicken = new FlxSprite(0, 0, AssetPaths.title_chicken__png);
		add(chicken);
		FlxTween.linearMotion(chicken, 0, 0, 0, 20, 0.5, true, { type: FlxTween.PINGPONG, ease: FlxEase.quadInOut } );
		
		spr = new FlxSprite(0, 0, AssetPaths.title_front_flames__png);
		fg_fire1 = spr;// = new FlxEffectSprite(spr, [bg_fire_effect]);
		add(fg_fire1);
		FlxTween.tween(fg_fire1, {x: FlxG.width}, 45, { type: FlxTween.LOOPING });
		FlxTween.tween(fg_fire1, {y: 10}, 1, { type: FlxTween.PINGPONG, ease: FlxEase.cubeInOut });
		//FlxTween.linearMotion(fg_fire1, 0, 0, FlxG.width, 0, 20, true, { type: FlxTween.LOOPING } );
		
		spr = new FlxSprite(-FlxG.width, 0, AssetPaths.title_front_flames__png);
		fg_fire2 = spr;// new FlxEffectSprite(spr, [bg_fire_effect]);
		FlxTween.tween(fg_fire2, {x: 0}, 45, { type: FlxTween.LOOPING });
		FlxTween.tween(fg_fire2, {y: 10}, 1, { type: FlxTween.PINGPONG, ease: FlxEase.cubeInOut });
		//FlxTween.linearMotion(fg_fire2, -FlxG.width, 0, 0, 0, 20, true, { type: FlxTween.LOOPING } );
		add(fg_fire2);
		
		txt = new FlxText(10, 50, 480, "La Culpa es de Clotilde\n(Blame Clotilde!)", 24, true);
		
		txt2 = new FlxText(10, 115, 480, "Por: Ciro Durán y Héctor Vargas", 16, true);
		
		button = new FlxButton(10, 140, "Soy un pollo", chicken_handler);
		button2 = new FlxButton(10, 170, "Créditos", credits_handler);
		button3 = new FlxButton(100, 140, "Soy un chef", chef_handler);
		
		add(txt);
		add(txt2);
		add(button);
		add(button2);
		add(button3);
		
		anim_ix = 0;
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update(elapsed:Float) : Void
	{
		super.update(elapsed);
	}
	
	public function chicken_handler()
	{
		Reg.tipo_juego = 0;
		FlxG.switchState(new PlayState());
	}
	
	public function chef_handler()
	{
		Reg.tipo_juego = 1;
		FlxG.switchState(new PlayState());
	}
	
	public function credits_handler()
	{
		FlxG.switchState(new CreditsState());
	}
}