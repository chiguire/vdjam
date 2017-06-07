package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.addons.effects.chainable.FlxWaveEffect;
import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.math.FlxRandom;
import flixel.util.FlxTimer;

/**
 * ...
 * @author Ciro Duran
 */
class GameOverState extends FlxState
{
	public var bg_sprite : FlxSprite;
	public var fire_effect : FlxWaveEffect;
	public var bg_fire1 : FlxSprite; // : FlxEffectSprite;
	public var bg_fire2 : FlxSprite; //: FlxEffectSprite;
	public var chef : FlxSprite;
	public var midground1 : FlxSprite;
	public var midground2 : FlxSprite;
	public var chicken : FlxSprite;
	public var fg_fire1 : FlxSprite; //: FlxEffectSprite;
	public var fg_fire2 : FlxSprite; //: FlxEffectSprite;
	
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
		
		//fire_effect = new FlxWaveEffect(FlxWaveMode.ALL, 5, -1, 5);
		var spr = new FlxSprite(0, 0, AssetPaths.title_background_flames__png);
		bg_fire1 = spr; // new FlxEffectSprite(spr, [fire_effect]);
		add(bg_fire1);
		tweens.push(FlxTween.tween(bg_fire1, {x: FlxG.width}, 45, { type: FlxTween.LOOPING }));
		tweens.push(FlxTween.tween(bg_fire1, {y: 10}, 1, { type: FlxTween.PINGPONG, ease: FlxEase.cubeInOut }));
		//tweens.push(FlxTween.linearMotion(bg_fire1, 0, 0, FlxG.width, 0, 45, true, { type: FlxTween.LOOPING } ));
		
		spr = new FlxSprite(-FlxG.width, 0, AssetPaths.title_background_flames__png);
		bg_fire2 = spr; //new FlxEffectSprite(spr, [fire_effect]);
		add(bg_fire2);
		tweens.push(FlxTween.tween(bg_fire2, {x: 0}, 45, { type: FlxTween.LOOPING }));
		tweens.push(FlxTween.tween(bg_fire2, {y: 10}, 1, { type: FlxTween.PINGPONG, ease: FlxEase.cubeInOut }));
		//tweens.push(FlxTween.linearMotion(bg_fire2, -FlxG.width, 0, 0, 0, 45, true, { type: FlxTween.LOOPING } ));
		
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
		fg_fire1 = spr; //new FlxEffectSprite(spr, [fire_effect]);
		add(fg_fire1);
		tweens.push(FlxTween.tween(fg_fire1, {x: FlxG.width}, 45, { type: FlxTween.LOOPING }));
		tweens.push(FlxTween.tween(fg_fire1, {y: 10}, 0.5, { type: FlxTween.PINGPONG, ease: FlxEase.cubeInOut }));
		//tweens.push(FlxTween.linearMotion(fg_fire1, 0, 0, FlxG.width, 0, 20, true, { type: FlxTween.LOOPING } ));
		
		spr = new FlxSprite(-FlxG.width, 0, AssetPaths.title_front_flames__png);
		fg_fire2 = spr; //new FlxEffectSprite(spr, [fire_effect]);
		tweens.push(FlxTween.tween(fg_fire2, {x: 0}, 45, { type: FlxTween.LOOPING }));
		tweens.push(FlxTween.tween(fg_fire2, {y: 10}, 0.5, { type: FlxTween.PINGPONG, ease: FlxEase.cubeInOut }));
		//tweens.push(FlxTween.linearMotion(fg_fire2, -FlxG.width, 0, 0, 0, 20, true, { type: FlxTween.LOOPING } ));
		add(fg_fire2);
		
		screen = new FlxSprite(0, 0);
		screen.makeGraphic(FlxG.width, FlxG.height, 0xff000000);
		screen.alpha = 0;
		screen.visible = false;
		add(screen);
		
		txt = new FlxText((FlxG.width - 400) / 2, FlxG.height / 2, 400, FlxG.random.getObject(textos), 16);
		txt.wordWrap = true;
		txt.alignment = "center";
		txt.alpha = 0;
		txt.visible = false;
		add(txt);
		
		timer = new FlxTimer();
		timer.start(3, timer_handler, 1);
	}
	
	public function timer_handler(timer:FlxTimer)
	{
		for (t in tweens)
		{
			t.cancel();
		}
		//fire_effect.speed = 0;
		screen.visible = true;
		txt.visible = true;
		FlxTween.tween(screen, { alpha: 0.6 }, 1);
		FlxTween.tween(txt, { alpha: 1 }, 1);
	}
	
	public override function update(elapsed:Float)
	{
		super.update(elapsed);
		
		if (screen.visible && (FlxG.keys.getIsDown().length > 0 || FlxG.mouse.justPressed))
		{
			FlxG.switchState(new MenuState());
		}
	}
}