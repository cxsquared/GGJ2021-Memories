package component;

import h2d.col.Bounds;
import h2d.Console;

class Camera implements IComponent {
	public static final type = "Camera";

	public var target:Entity;
	public var bounds:Bounds;
	public var offsetX:Float;
	public var offsetY:Float;
	public var speed:Float = 10;
	public var deadzone:Float = 5;

	public function new(target:Entity, bounds:Bounds, offsetX:Float, offsetY:Float) {
		this.target = target;
		this.bounds = bounds;
		this.offsetX = offsetX;
		this.offsetY = offsetY;
	}

	public function getType():String {
		return type;
	}

	public function log(console:Console, ?color:Int) {}

	public function remove() {}
}
