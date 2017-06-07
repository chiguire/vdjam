package proto;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import flixel.util.FlxTimer;

/**
 * ...
 * @author Ciro Duran
 */
class Notification extends FlxSprite
{
	public var text : FlxText;
	public var timer : FlxTimer;

	public function new() 
	{
		super(0, 0);
		makeGraphic(300, 120);
		
		scrollFactor.set(0, 0);
		
		text = new FlxText(0, 0, 290, "Esto es un texto bastante largo que estoy escribiendo para ver hasta donde puede llegar lo que vamos a decir y esperemos que tenga bastante espacio para poder echar el cuento de la vaina y decir las cosas como son. No ocultaremos nada.", 16);
		text.wordWrap = true;
		text.color = 0x00000000;
		
		stamp(text, 5, 5);
		
		timer = new FlxTimer();
		visible = false;
	}
	
	public function appear()
	{
		var obj = this;
		alpha = 0;
		visible = true;
		exists = true;
		
		FlxTween.tween(obj, { alpha: 1.0 }, 1, { onComplete: function(tween:FlxTween)
		{
			
			timer.start(5, function(timer:FlxTimer)
			{
				
				FlxTween.tween(obj, { alpha: 0.0 }, 1, { onComplete: function (tween:FlxTween)
				{
					
					visible = false;
					kill();
				}});
			});
		}});
	}
	
	public function set_text(str:String)
	{
		FlxSpriteUtil.fill(this, FlxColor.WHITE);
		text.text = str;
		stamp(text, 5, 5);
	}
}