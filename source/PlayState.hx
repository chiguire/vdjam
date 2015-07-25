package;

import flixel.addons.display.FlxBackdrop;
import flixel.addons.tile.FlxTilemapExt;
import flixel.effects.FlxFlicker;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxObject;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxColor;
import flixel.util.FlxRandom;
import flixel.util.FlxSort;
import flixel.FlxCamera;
import proto.FlxZSprite;
import proto.Notification;
import proto.Pollo;
import proto.Rostipollo;
import proto.Viga;

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
	
	public var preocupaciones : Array<String> = [
		"Hey, pollo, ¿por qué escapas de tu destino?",
		"¿Sabías que hace un minuto eras 100BsF más barato?",
		"Pobre Pepito, él quería comer pollo y ahora no puede. Por tu culpa."
	];
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		
		backdrop = new FlxBackdrop(AssetPaths.backdrop__png, 1, 1, true, true);
		add(backdrop);
		
		pollo = new Pollo(320, 10, 0);
		
		vigas = new Array<Viga>();
		all_stuff = new FlxTypedGroup<FlxZSprite>();
		
		for (i in 0...6)
		{
			var v = new Viga(210, i);
			v.z_angle = i * 360.0 / 6;
			all_stuff.add(v);
			
			for (i in 0...4)
			{
				var rp = new Rostipollo((i + 1) * 250, 0);
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
		
		notifications = new FlxTypedGroup<Notification>();
		add(notifications);
		
		var overlayCamera = new FlxCamera(0, 0, FlxG.width, FlxG.height);
		overlayCamera.setBounds(0, 0, FlxG.width*3, 480, false);
		overlayCamera.follow(pollo, FlxCamera.STYLE_PLATFORMER, 1);
		FlxG.cameras.reset(overlayCamera);
		FlxG.worldBounds.set( -30, -300, FlxG.width * 3 + 60, FlxG.height + 300);
		
		//FlxG.watch.add(pollo, "velocity");
		FlxG.watch.add(pollo, "standing_on_viga_counter");
		//FlxG.watch.add(pollo, "is_standing_on_viga");
		//FlxG.watch.add(pollo, "z");
		//FlxG.watch.add(vigas.members[0], "z");
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
		pollo.acceleration.y = 300;
		
		FlxG.collide(pollo, boundaries);
		
		for (v in vigas)
		{
			for (rp in v.rostipollos.members)
			{
				rp.allowCollisions = FlxObject.NONE;
			}
		}
		
		if (current_viga != null)
		{
			for (rp in current_viga.rostipollos.members)
			{
				rp.allowCollisions = FlxObject.ANY;
			}
			FlxG.collide(pollo, current_viga.rostipollos);
		}
		
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
		if (FlxG.keys.anyJustPressed(["UP", "W"]) && pollo.is_standing_on_viga)
		{
			pollo.velocity.y -= speed * 1;
			pollo.is_standing_on_viga = false;
			pollo.standing_on_viga_counter = 0;
		}
		
        pollo.velocity.x =
            if (FlxG.keys.anyPressed(["LEFT", "A"])) -speed;
            else if (FlxG.keys.anyPressed(["RIGHT", "D"])) speed;
            else 0;
			
		if (FlxG.keys.anyJustPressed(["Z"]))
		{
			var n = cast(notifications.recycle(Notification, [], true, true), Notification);
			n.x = FlxRandom.intRanged(20, FlxG.width - 320);
			n.y = FlxRandom.intRanged(FlxG.height - 180, FlxG.height - 130);
			n.set_text(FlxRandom.getObject(preocupaciones));
			n.appear();
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
			p.standing_on_viga_counter = 7;
			current_viga = cast(v, Viga);
		}
		else if (Std.is(v, Rostipollo))
		{
			p.z = v.viga.z;
			p.is_standing_on_viga = true;
			p.standing_on_viga_counter = 7;
			current_viga = cast(v.viga, Viga);
		}
	}
}