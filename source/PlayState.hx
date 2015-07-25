package;

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
import flixel.util.FlxSort;
import proto.FlxZSprite;
import proto.Pollo;
import proto.Viga;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	public var pollo : Pollo;
	public var vigas : FlxTypedGroup<FlxZSprite>;
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		
		pollo = new Pollo(320, 10, 0);
		pollo.makeGraphic(60, 60, FlxColor.RED);
		
		vigas = new FlxTypedGroup<FlxZSprite>();
		
		for (i in 0...6)
		{
			var v = new Viga(210, i);
			v.z_angle = i * 360.0 / 6;
			vigas.add(v);
		}
		
		vigas.add(pollo);
		add(vigas);
		
		FlxG.watch.add(pollo, "is_standing_on_viga");
		FlxG.watch.add(pollo, "z");
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
		pollo.acceleration.y = 240;
		
		readInput();
		if (!FlxG.keys.anyPressed(["DOWN", "S"]))
		{
			if (!FlxG.overlap(pollo, vigas, set_pollo_z, check_viga_collide))
			{
				pollo.is_standing_on_viga = false;
			}
		}
		
		if (pollo.y > FlxG.height + 100)
		{
			pollo.y = 10;
			FlxG.camera.flash();
		}
		
		vigas.sort(FlxZSprite.byZ, FlxSort.ASCENDING);
	}	
	
	public function readInput()
    {
        var speed = 200;
		if (FlxG.keys.anyJustPressed(["UP", "W"]))
		{
			pollo.velocity.y = -speed * 20;
			pollo.is_standing_on_viga = false;
		}
		
        pollo.velocity.x =
            if (FlxG.keys.anyPressed(["LEFT", "A"])) -speed;
            else if (FlxG.keys.anyPressed(["RIGHT", "D"])) speed;
            else 0;
    }
	
	public function check_viga_collide(ObjA:Dynamic, ObjB:Dynamic):Bool
    {
        if (Std.is(ObjA, Pollo) && Std.is(ObjB, Viga) && cast(ObjA,Pollo).is_standing_on_viga)
        {
            return false;
        }
        return FlxObject.separate(ObjA, ObjB);
    }
	
	public function set_pollo_z(pollo, viga)
	{
		pollo.z = viga.z;
		pollo.is_standing_on_viga = true;
	}
}