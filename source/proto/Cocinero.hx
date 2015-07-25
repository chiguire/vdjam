package proto;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;
import flixel.util.FlxVector;

/**
 * ...
 * @author Ciro Duran
 */
class Cocinero extends FlxSpriteGroup
{
	private var body : FlxSprite;
	private var left_arm_1 : FlxSprite;
	private var left_arm_2 : FlxSprite;
	private var right_arm_1 : FlxSprite;
	private var right_arm_2 : FlxSprite;
	private var _distance : Float;
	public var max_speed : FlxPoint = FlxPoint.get(200, 0);
	
	public function new(X:Float=0, Y:Float=0, MaxSize:Int=0) 
	{
		super(X, Y, MaxSize);
		
		body = new FlxSprite(0, 0);
		body.makeGraphic(140, 400, FlxColor.CHARTREUSE);
		add(body);
		
		left_arm_1 = new FlxSprite(-10, 60);
		left_arm_1.makeGraphic(20, 80, FlxColor.BROWN);
		left_arm_1.origin.set(10, 5);
		add(left_arm_1);
		
		left_arm_2 = new FlxSprite(-10, 135);
		left_arm_2.makeGraphic(20, 80, FlxColor.CORAL);
		left_arm_2.origin.set(10, 5);
		add(left_arm_2);
		
		right_arm_1 = new FlxSprite(130, 60);
		right_arm_1.makeGraphic(20, 80, FlxColor.IVORY);
		right_arm_1.origin.set(10, 5);
		add(right_arm_1);
		
		right_arm_2 = new FlxSprite(130, 135);
		right_arm_2.makeGraphic(20, 80, FlxColor.KHAKI);
		right_arm_2.origin.set(10, 5);
		add(right_arm_2);
	}
	
	
	public override function update()
	{
		super.update();
		left_arm_2.angle += 1;
		right_arm_2.angle -= 1;
	}
	
	public function seek(target:FlxSprite) : Void
	{
		var temp_force : FlxVector = FlxVector.get(0,0);
		var temp_force2 = FlxVector.get(0,0);
		_distance = FlxMath.distanceBetween(target, this);
		
		if (_distance <= 300)
		{
			temp_force.x = (target.x + (target.width/2.0)) - (x + (this.width/2.0)); // desired velocity
			temp_force.y = (target.y + (target.width/2.0)) - (y + (this.width/2.0));
			temp_force = temp_force.normalize();
			
			temp_force2.set(temp_force.x * max_speed.x, temp_force.y * max_speed.y).subtractPoint(velocity);
		}
		
		acceleration.set(temp_force2.x, temp_force2.y);
	}
}