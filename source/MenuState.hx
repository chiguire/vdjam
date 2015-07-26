package;

import flixel.addons.effects.FlxWaveSprite;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.tweens.motion.QuadMotion;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	public var bg_sprite : FlxSprite;
	public var bg_fire1 : FlxWaveSprite;
	public var bg_fire2 : FlxWaveSprite;
	public var chef : FlxSprite;
	public var midground1 : FlxSprite;
	public var midground2 : FlxSprite;
	public var chicken : FlxSprite;
	public var fg_fire1 : FlxWaveSprite;
	public var fg_fire2 : FlxWaveSprite;
	
	public var txt : FlxText;
	public var txt2 : FlxText;
	public var button : FlxButton;
	public var button2 : FlxButton;
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		
		bg_sprite = new FlxSprite(0, 0, AssetPaths.title_background_mate__png);
		add(bg_sprite);
		
		var spr = new FlxSprite(0, 0, AssetPaths.title_background_flames__png);
		bg_fire1 = new FlxWaveSprite(spr, WaveMode.ALL, 5, -1, 5);
		add(bg_fire1);
		FlxTween.linearMotion(bg_fire1, 0, 0, FlxG.width, 0, 45, true, { type: FlxTween.LOOPING } );
		
		spr = new FlxSprite(-FlxG.width, 0, AssetPaths.title_background_flames__png);
		bg_fire2 = new FlxWaveSprite(spr, WaveMode.ALL, 5, -1, 5);
		add(bg_fire2);
		FlxTween.linearMotion(bg_fire2, -FlxG.width, 0, 0, 0, 45, true, { type: FlxTween.LOOPING } );
		
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
		fg_fire1 = new FlxWaveSprite(spr, WaveMode.ALL, 5, -1, 5);
		add(fg_fire1);
		FlxTween.linearMotion(fg_fire1, 0, 0, FlxG.width, 0, 20, true, { type: FlxTween.LOOPING } );
		
		spr = new FlxSprite(-FlxG.width, 0, AssetPaths.title_front_flames__png);
		fg_fire2 = new FlxWaveSprite(spr, WaveMode.ALL, 5, -1, 5);
		FlxTween.linearMotion(fg_fire2, -FlxG.width, 0, 0, 0, 20, true, { type: FlxTween.LOOPING } );
		add(fg_fire2);
		
		txt = new FlxText(10, 50, 480, "La Culpa es de Clotilde\n(Blame Clotilde!)", 20, true);
		
		txt2 = new FlxText(10, 110, 480, "Por: Ciro Durán (@chiguire) y Héctor Vargas (@Baha_Z).\nJulio 2015.", 8, true);
		
		button = new FlxButton(10, 140, "Comenzar", play_handler);
		button2 = new FlxButton(10, 170, "Créditos", null);
		
		add(txt);
		add(txt2);
		add(button);
		add(button2);
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
	}	
	
	public function play_handler()
	{
		FlxG.switchState(new PlayState());
	}
}