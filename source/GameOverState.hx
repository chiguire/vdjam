package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.addons.effects.FlxWaveSprite;
import flixel.util.FlxRandom;
import flixel.util.FlxTimer;

/**
 * ...
 * @author Ciro Duran
 */
class GameOverState extends FlxState
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
	
	public var timer : FlxTimer;
	
	public var tweens : Array<FlxTween>;
	
	public var screen : FlxSprite;
	public var txt : FlxText;
	
	public var textos = [
		"Pepito te comió con mucho gusto. Eso sí, sus papás se gastaron una millonada en pagarte.",
		"¡Quién sabe cuando vuelvas a aparecer!",
		"Y el pollo que había en la mesa también se lo comió.",
		"Hubo quién intentó refrigerarte para revenderte una semana después, pero ya no tenías tan buena apariencia.",
		"Siempre me pregunté cómo hacían para servir puras patas de pollo en el comedor de la universidad.",
		"Una linda parejita te llevó para cena romántica. Hicieron caballito en la moto y todo.",
		"Supongo que ya no sabremos por qué cruzaste la calle.",
		"Dos días después de que Pepito te comió ya valías el doble.",
		"Después de 8 horas en cola para comprarte finalmente te tengo.",
		"Compré medio cartón con tus hijos el otro día. Fueron un delicioso omelette.",
		"Hice nuggets con tu esposa el otro día, ahora es tu turno.",
	];
	
	public override function create()
	{
		super.create();
		tweens = new Array<FlxTween>();
		
		bg_sprite = new FlxSprite(0, 0, AssetPaths.title_background_mate__png);
		add(bg_sprite);
		
		var spr = new FlxSprite(0, 0, AssetPaths.title_background_flames__png);
		bg_fire1 = new FlxWaveSprite(spr, WaveMode.ALL, 5, -1, 5);
		add(bg_fire1);
		tweens.push(FlxTween.linearMotion(bg_fire1, 0, 0, FlxG.width, 0, 45, true, { type: FlxTween.LOOPING } ));
		
		spr = new FlxSprite(-FlxG.width, 0, AssetPaths.title_background_flames__png);
		bg_fire2 = new FlxWaveSprite(spr, WaveMode.ALL, 5, -1, 5);
		add(bg_fire2);
		tweens.push(FlxTween.linearMotion(bg_fire2, -FlxG.width, 0, 0, 0, 45, true, { type: FlxTween.LOOPING } ));
		
		chef = new FlxSprite(0, 0, AssetPaths.title_chef__png);
		add(chef);
		tweens.push(FlxTween.linearMotion(chef, 0, 0, 0, -20, 1, true, { type: FlxTween.PINGPONG, ease: FlxEase.quadInOut } ));
		tweens.push(FlxTween.linearMotion(chef, 0, 0, -100, 0, 2, true, { startDelay: 1, type: FlxTween.ONESHOT } ));
		
		midground1 = new FlxSprite(0, 0, AssetPaths.title_midground__png);
		add(midground1);
		tweens.push(FlxTween.linearMotion(midground1, 0, 0, FlxG.width, 0, 30, true, { type: FlxTween.LOOPING } ));
		
		midground2 = new FlxSprite(-FlxG.width, 0, AssetPaths.title_midground__png);
		add(midground2);
		tweens.push(FlxTween.linearMotion(midground2, -FlxG.width, 0, 0, 0, 30, true, { type: FlxTween.LOOPING } ));
		
		chicken = new FlxSprite(0, 0, AssetPaths.title_chicken__png);
		add(chicken);
		tweens.push(FlxTween.linearMotion(chicken, 0, 0, 0, 20, 0.5, true, { type: FlxTween.PINGPONG, ease: FlxEase.quadInOut } ));
		tweens.push(FlxTween.linearMotion(chicken, 0, 0, 80, 0, 2, true, { startDelay: 1, type: FlxTween.ONESHOT } ));
		
		spr = new FlxSprite(0, 0, AssetPaths.title_front_flames__png);
		fg_fire1 = new FlxWaveSprite(spr, WaveMode.ALL, 5, -1, 5);
		add(fg_fire1);
		tweens.push(FlxTween.linearMotion(fg_fire1, 0, 0, FlxG.width, 0, 20, true, { type: FlxTween.LOOPING } ));
		
		spr = new FlxSprite(-FlxG.width, 0, AssetPaths.title_front_flames__png);
		fg_fire2 = new FlxWaveSprite(spr, WaveMode.ALL, 5, -1, 5);
		tweens.push(FlxTween.linearMotion(fg_fire2, -FlxG.width, 0, 0, 0, 20, true, { type: FlxTween.LOOPING } ));
		add(fg_fire2);
		
		screen = new FlxSprite(0, 0);
		screen.makeGraphic(FlxG.width, FlxG.height, 0xff000000);
		screen.alpha = 0;
		screen.visible = false;
		add(screen);
		
		txt = new FlxText((FlxG.width - 400) / 2, FlxG.height / 2, 400, FlxRandom.getObject(textos), 16);
		txt.wordWrap = true;
		txt.alignment = "center";
		txt.alpha = 0;
		txt.visible = false;
		add(txt);
		
		timer = new FlxTimer(3, timer_handler, 1);
	}
	
	public function timer_handler(timer:FlxTimer)
	{
		for (t in tweens)
		{
			t.cancel();
		}
		bg_fire1.speed = 0;
		bg_fire2.speed = 0;
		fg_fire1.speed = 0;
		fg_fire2.speed = 0;
		screen.visible = true;
		txt.visible = true;
		FlxTween.tween(screen, { alpha: 0.6 }, 1);
		FlxTween.tween(txt, { alpha: 1 }, 1);
	}
	
	public override function update()
	{
		super.update();
		
		if (screen.visible && (FlxG.keys.getIsDown().length > 0 || FlxG.mouse.justPressed))
		{
			FlxG.switchState(new MenuState());
		}
	}
}