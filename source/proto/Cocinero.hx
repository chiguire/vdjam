package proto;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxVector;

/**
 * ...
 * @author Ciro Duran
 */
class Cocinero extends FlxSpriteGroup
{
	private var body : FlxSprite;
	private var left_arm_1 : FlxSprite;
	private var left_arm_2 : FlxSprite;
	private var left_arm_3 : FlxSprite;
	private var right_arm_1 : FlxSprite;
	private var right_arm_2 : FlxSprite;
	private var right_arm_3 : FlxSprite;
	public var knife_hotspot : FlxSprite;
	public var camera_hotspot : FlxSprite;
	public var _distance : Float;
	public var max_speed : FlxPoint = FlxPoint.get(150, 0);
	
	public function new(X:Float=0, Y:Float=0, MaxSize:Int=0) 
	{
		super(X, Y, MaxSize);
		
		body = new FlxSprite(0, 0, AssetPaths.chef_body__png);
		add(body);
		
		camera_hotspot = new FlxSprite(0, body.height);
		camera_hotspot.makeGraphic(1, 1, FlxColor.TRANSPARENT);
		add(camera_hotspot);
		
		left_arm_1 = new FlxSprite(30, 280, AssetPaths.chef_sidearm_L__png);
		left_arm_1.origin.set(27, 31);
		add(left_arm_1);
		
		left_arm_2 = new FlxSprite(30, 400, AssetPaths.chef_arm_L__png);
		left_arm_2.origin.set(29, 20);
		add(left_arm_2);
		
		left_arm_3 = new FlxSprite(30, 500, AssetPaths.chef_knife_L__png);
		left_arm_3.origin.set(30, 31);
		add(left_arm_3);
		
		knife_hotspot = new FlxSprite(30, 500);
		knife_hotspot.makeGraphic(50, 50, FlxColor.TRANSPARENT);
		knife_hotspot.centerOrigin();
		add(knife_hotspot);
		
		right_arm_1 = new FlxSprite(160, 280, AssetPaths.chef_sidearm_R__png);
		right_arm_1.origin.set(24, 29);
		add(right_arm_1);
		
		right_arm_2 = new FlxSprite(160, 400, AssetPaths.chef_arm_R__png);
		right_arm_2.origin.set(20, 18);
		add(right_arm_2);
		
		right_arm_3 = new FlxSprite(160, 500, AssetPaths.chef_brush_R__png);
		right_arm_3.origin.set(29, 20);
		add(right_arm_3);
	}
	
	public var l_sidearm_angle(default,set): Float = 44;
	public var l_arm_angle(default,set): Float = -342;
	public var l_knife_angle(default,set): Float = -30;
	public var r_sidearm_angle(default,set): Float = -28;
	public var r_arm_angle(default,set): Float = -2;
	public var r_brush_angle(default,set): Float = 60;
	
	public override function update(elapsed:Float)
	{
		super.update(elapsed);
		set_arms_angles(l_sidearm_angle, l_arm_angle, l_knife_angle, r_sidearm_angle, r_arm_angle, r_brush_angle);
	}
	
	public function set_arms_angles(l_sidearm:Float, l_arm:Float, l_knife:Float, r_sidearm:Float, r_arm:Float, r_brush:Float) //Degress
	{
		left_arm_1.angle = l_sidearm;
		var v = FlxVector.get(0, left_arm_1.height - 30);
		v.rotateByDegrees(l_sidearm);
		
		left_arm_2.x = left_arm_1.x + left_arm_1.origin.x + v.x - left_arm_2.origin.x;
		left_arm_2.y = left_arm_1.y + left_arm_1.origin.y + v.y - left_arm_2.origin.y;
		left_arm_2.angle = l_sidearm + l_arm;
		
		v = FlxVector.get(0, left_arm_2.height - 30);
		v.rotateByDegrees(l_sidearm + l_arm);
		left_arm_3.x = left_arm_2.x + left_arm_2.origin.x + v.x - left_arm_3.origin.x;
		left_arm_3.y = left_arm_2.y + left_arm_2.origin.y + v.y - left_arm_3.origin.y;
		left_arm_3.angle = l_sidearm + l_arm + l_knife;
		
		v = FlxVector.get(0, left_arm_3.height - 50);
		v.rotateByDegrees(l_sidearm + l_arm + l_knife);
		knife_hotspot.x = left_arm_3.x + left_arm_3.origin.x + v.x - knife_hotspot.origin.x;
		knife_hotspot.y = left_arm_3.y + left_arm_3.origin.y + v.y - knife_hotspot.origin.y;
		
		right_arm_1.angle = r_sidearm;
		var v = FlxVector.get(0, right_arm_1.height - 30);
		v.rotateByDegrees(r_sidearm);
		
		right_arm_2.x = right_arm_1.x + right_arm_1.origin.x + v.x - right_arm_2.origin.x;
		right_arm_2.y = right_arm_1.y + right_arm_1.origin.y + v.y - right_arm_2.origin.y;
		right_arm_2.angle = r_sidearm + r_arm;
		
		v = FlxVector.get(0, right_arm_2.height - 10);
		v.rotateByDegrees(r_sidearm + r_arm);
		right_arm_3.x = right_arm_2.x + right_arm_2.origin.x + v.x - right_arm_3.origin.x;
		right_arm_3.y = right_arm_2.y + right_arm_2.origin.y + v.y - right_arm_3.origin.y;
		right_arm_3.angle = r_sidearm + r_arm + r_brush;
		
	}
	
	public function seek(target:FlxSprite) : Void
	{
		var temp_force : FlxVector = FlxVector.get(0,0);
		var temp_force2 = FlxVector.get(0,0);
		_distance = FlxMath.distanceBetween(target, this);
		
		temp_force.x = (target.x + (target.width/2.0)) - (x + (this.width/2.0)); // desired velocity
		temp_force.y = (target.y + (target.width/2.0)) - (y + (this.width/2.0));
		temp_force = temp_force.normalize();
		
		temp_force2.set(temp_force.x * max_speed.x, temp_force.y * max_speed.y).subtractPoint(velocity);
		
		acceleration.set(temp_force2.x, temp_force2.y);
	}
	
	public function ik_solve(target:FlxSprite)
	{
		l_arm_angle += solve_ik_solve(left_arm_2, target);
		l_sidearm_angle += solve_ik_solve(left_arm_1, target);
		r_brush_angle += solve_ik_solve(right_arm_3, target);
		r_arm_angle += solve_ik_solve(right_arm_2, target);
		r_sidearm_angle += solve_ik_solve(right_arm_1, target);
	}
	
	private function solve_ik_solve(arm:FlxSprite, target:FlxSprite)
	{
		var v = FlxVector.get(0, arm.height - 20);
		v.rotateByDegrees(arm.angle);
		var v_p = FlxVector.get(v.x, v.y);
		v_p.rotateByDegrees(90);
		
		var v_f = FlxVector.get((target.x + target.origin.x) - (arm.x + arm.origin.x + v.x),
								(target.y + target.origin.y) - (arm.y + arm.origin.y + v.y));
		
		var dot_product = v_f.dotProdWithNormalizing(v_p);
		
		return dot_product*0.005;
	}
	
	public function set_l_sidearm_angle(value:Float)
	{
		return l_sidearm_angle = FlxMath.bound(value, 44, 190);
	}
	
	public function set_l_arm_angle(value:Float)
	{
		return l_arm_angle = FlxMath.bound(value, -342, -200);
	}
	
	public function set_l_knife_angle(value:Float)
	{
		return l_knife_angle = FlxMath.bound(value, -60, 60);
	}
	
	public function set_r_sidearm_angle(value:Float)
	{
		return r_sidearm_angle = FlxMath.bound(value, -180, -16);
	}
	
	public function set_r_arm_angle(value:Float)
	{
		return r_arm_angle = FlxMath.bound(value, -124, 0);
	}
	
	public function set_r_brush_angle(value:Float)
	{
		return r_brush_angle = FlxMath.bound(value, -60, 60);
	}
}