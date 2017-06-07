package;

import flixel.addons.display.FlxBackdrop;
import flixel.addons.tile.FlxTilemapExt;
import flixel.effects.FlxFlicker;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxObject;
import flixel.group.FlxGroup;
import flixel.input.keyboard.FlxKey;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import flixel.math.FlxRandom;
import flixel.util.FlxSort;
import flixel.FlxCamera;
import flixel.util.FlxTimer;
import proto.Cocinero;
import proto.FlxZSprite;
import proto.Notification;
import proto.Pollo;
import proto.Rostipollo;
import proto.Viga;
import proto.Fire;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	public var backdrop : FlxBackdrop;
	public var pollo : Pollo;
	public var all_stuff : FlxTypedGroup<FlxZSprite>;
	public var vigas : Array<Viga>;
	public var boundaries : FlxGroup;
	public var notifications : FlxTypedGroup<Notification>;
	public var current_viga : Null<Viga>;
	public var cocinero : Cocinero;
	public var fire : Fire;
	public var notification_timer : FlxTimer;
	public var drop_timer : FlxTimer;
	
	public var preocupaciones : Array<String> = [
		"Hey, pollo, ¿por qué escapas de tu destino?",
		"¿Sabías que hace un minuto eras 100BsF más barato?",
		"Pobre Pepito, él quería comer pollo y ahora no puede. Por tu culpa.",
		"Sería más fácil bachaquearte si no tuvieses fecha de expiración.",
		"Pónselo fácil al cocinero, mira que él también tiene que ganarse la vida.",
		"Si el cocinero no trabaja no come. Si tú trabajas terminas comido.",
		"¿Sabías que Almacén Don Manolo vende barat... bueno, precios una hora más baratos que en otros lados.",
		"Eres un pollo asado único, como todos los demás.",
		"¡Levántense, pollos, y anden conmigo en contra de la opresión humana alimenticia!",
		"Jan es calvo"
	];
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		
		if (FlxG.random.int(0, 1) == 0)
		{
			FlxG.sound.playMusic(AssetPaths.test__ogg, 0.6, true);
		}
		else
		{
			FlxG.sound.playMusic(AssetPaths.vdj__ogg, 0.6, true);
		}
		
		backdrop = new FlxBackdrop(AssetPaths.kitchen__png, 0.84, 1, false, false);
		add(backdrop);
		
		cocinero = new Cocinero(FlxG.random.int(500, FlxG.width*3), 0);
		add(cocinero);
		
		pollo = new Pollo(320, 10, 0);
		
		vigas = new Array<Viga>();
		all_stuff = new FlxTypedGroup<FlxZSprite>();
		
		for (i in 0...4)
		{
			var v = new Viga(210, i);
			v.z_angle = i * 360.0 / 4;
			all_stuff.add(v);
			
			for (j in 0...6)
			{
				if (i == 2 && j == 0)
				{
					continue;
				}
				var rp = new Rostipollo((j + 1) * 260, 0);
				rp.viga = v;
				v.rostipollos.add(rp);
				all_stuff.add(rp);
			}
			vigas.push(v);
		}
		
		all_stuff.add(pollo);
		add(all_stuff);
		
		boundaries = new FlxGroup();
		
		var boundary = new FlxSprite( -30, -300);
		boundary.makeGraphic(30, FlxG.height + 600, FlxColor.TRANSPARENT);
		boundary.immovable = true;
		boundaries.add(boundary);
		
		boundary = new FlxSprite( FlxG.width*3, -300);
		boundary.makeGraphic(30, FlxG.height + 600, FlxColor.TRANSPARENT);
		boundary.immovable = true;
		boundaries.add(boundary);
		add(boundaries);
		
		fire = new Fire();
		add(fire);
		
		notifications = new FlxTypedGroup<Notification>();
		add(notifications);
		
		if (Reg.tipo_juego == 1)
		{
			var help = new FlxSprite(0, 0, AssetPaths.help__png);
			help.scrollFactor.set(0, 0);
			help.x = FlxG.width - help.width;
			help.y = 0;
			add(help);
		}
		
		var overlayCamera = new FlxCamera(0, 0, FlxG.width, FlxG.height);
		overlayCamera.setScrollBoundsRect(0, 0, FlxG.width * 3, 480, false);
		if (Reg.tipo_juego == 0)
		{
			overlayCamera.follow(pollo, FlxCameraFollowStyle.PLATFORMER, 1);
		}
		else if (Reg.tipo_juego == 1)
		{
			overlayCamera.follow(cocinero.camera_hotspot, FlxCameraFollowStyle.PLATFORMER, 1);
		}
		FlxG.cameras.reset(overlayCamera);
		FlxG.worldBounds.set( -30, -300, FlxG.width * 3 + 60, FlxG.height + 300);
		
		notification_timer = new FlxTimer();
		notification_timer.start(15, notification_handler, 0);
		drop_timer = new FlxTimer();
		drop_timer.start(60, drop_handler, 0);
		
		//FlxG.watch.add(cocinero, "l_sidearm_angle");
		//FlxG.watch.add(cocinero, "l_arm_angle");
		//FlxG.watch.add(cocinero, "l_knife_angle");
		//FlxG.watch.add(cocinero, "r_sidearm_angle");
		//FlxG.watch.add(cocinero, "r_arm_angle");
		//FlxG.watch.add(cocinero, "r_brush_angle");
		FlxG.watch.add(pollo, "x");
		FlxG.watch.add(pollo, "direction");
		FlxG.watch.add(pollo.velocity, "x");
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
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		pollo.acceleration.y = 300;
		
		FlxG.collide(pollo, boundaries);
		FlxG.overlap(pollo, cocinero.knife_hotspot, null, gameover_handler);
		
		if (!FlxG.keys.anyPressed(["DOWN", "S"]))
		{
			if (!FlxG.overlap(pollo, all_stuff, set_pollo_z, check_viga_collide))
			{
				if (pollo.standing_on_viga_counter > 0)
				{
					pollo.standing_on_viga_counter--;
				}
				else
				{
					pollo.is_standing_on_viga = false;
					current_viga = null;
				}
			}
		}
		
		for (v in vigas)
		{
			if (v.dropped && v.y > FlxG.height * 2)
			{
				for (rp in v.rostipollos)
				{
					rp.kill();
				}
				v.rostipollos.clear();
				v.kill();
				vigas.remove(v);
			}
		}
		
		cocinero.seek(pollo);
		if (Reg.tipo_juego == 0)
		{
			cocinero.ik_solve(pollo);
		}
		if (Reg.tipo_juego == 1)
		{
			pollo.move_by_yourself(cocinero);
		}
		
		readInput();
		
		if (pollo.y > FlxG.height + 100)
		{
			pollo.y = 10;
			FlxG.camera.flash();
			FlxFlicker.flicker(pollo, 1);
		}
		
		all_stuff.sort(FlxZSprite.byZ, FlxSort.ASCENDING);
	}	
	
	public function readInput()
    {
        var speed = 200;
		if (Reg.tipo_juego == 0)
		{
			if (FlxG.keys.anyJustPressed(["UP", "W"]) && pollo.is_standing_on_viga)
			{
				pollo.velocity.y -= speed * 1;
				pollo.is_standing_on_viga = false;
				pollo.standing_on_viga_counter = 0;
				pollo.jump();
			}
			
			pollo.velocity.x =
				if (FlxG.keys.anyPressed(["LEFT", "A"])) -speed;
				else if (FlxG.keys.anyPressed(["RIGHT", "D"])) speed;
				else 0;
			
			pollo.pressed_left = pollo.velocity.x > 0;
			pollo.pressed_right = pollo.velocity.x < 0;
		}
		
		if (Reg.tipo_juego == 1)
		{
			cocinero.l_sidearm_angle += if (FlxG.keys.pressed.R) -2; else if (FlxG.keys.pressed.T) 2; else 0;
			cocinero.l_arm_angle     += if (FlxG.keys.pressed.F) -2; else if (FlxG.keys.pressed.G) 2; else 0;
			cocinero.l_knife_angle   += if (FlxG.keys.pressed.V) -2; else if (FlxG.keys.pressed.B) 2; else 0;
			cocinero.r_sidearm_angle += if (FlxG.keys.pressed.Y) -2; else if (FlxG.keys.pressed.U) 2; else 0;
			cocinero.r_arm_angle     += if (FlxG.keys.pressed.H) -2; else if (FlxG.keys.pressed.J) 2; else 0;
			cocinero.r_brush_angle   += if (FlxG.keys.pressed.N) -2; else if (FlxG.keys.pressed.M) 2; else 0;
		}
    }
	
	public function check_viga_collide(ObjA:Dynamic, ObjB:Dynamic):Bool
    {
        if (Std.is(ObjA, Pollo) && Std.is(ObjB, Viga) && cast(ObjA,Pollo).is_standing_on_viga)
        {
            return false;
        }
        return FlxObject.separate(ObjA, ObjB);
    }
	
	public function set_pollo_z(p, v)
	{
		if (Std.is(v, Viga))
		{
			p.z = v.z;
			p.is_standing_on_viga = true;
			p.standing_on_viga_counter = 8;
			current_viga = cast(v, Viga);
		}
		else if (Std.is(v, Rostipollo))
		{
			p.z = v.viga.z;
			p.is_standing_on_viga = true;
			p.standing_on_viga_counter = 8;
			current_viga = cast(v.viga, Viga);
		}
	}
	
	public function notification_handler(timer:FlxTimer)
	{
		var n = cast(notifications.recycle(Notification, function () { return new Notification(); }, true, true), Notification);
		n.x = FlxG.random.int(20, FlxG.width - 320);
		n.y = FlxG.random.int(FlxG.height - 180, FlxG.height - 130);
		n.set_text(FlxG.random.getObject(preocupaciones));
		n.appear();
	}
	
	public function drop_handler(timer:FlxTimer)
	{
		var vigas_not_dropped = new Array<Viga>();
		
		for (v in vigas)
		{
			if (!v.dropped)
			{
				vigas_not_dropped.push(v);
			}
		}
		
		if (vigas_not_dropped.length == 1)
		{
			return;
		}
		
		var v = FlxG.random.getObject(vigas);
		
		v.drop();
	}
	
	public function gameover_handler(a:Dynamic, b:Dynamic)
	{
		FlxG.sound.music.stop();
		FlxG.switchState(new GameOverState());
		return true;
	}
}