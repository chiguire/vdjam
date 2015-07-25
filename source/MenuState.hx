package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	public var txt : FlxText;
	public var txt2 : FlxText;
	public var button : FlxButton;
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		
		txt = new FlxText(10, 10, 480, "VDJAM2015 - Pollos", 16, true);
		txt2 = new FlxText(10, 40, 480, "Por: Ciro Durán (@chiguire) y Héctor Vargas (@Baha_Z). Julio 2015.", 8, true);
		button = new FlxButton(10, 60, "Comenzar", play_handler);
		
		add(txt);
		add(txt2);
		add(button);
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