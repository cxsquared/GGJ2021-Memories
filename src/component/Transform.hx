package component;

import h2d.Console;

class Transform implements IComponent {
	public static final type = "Transform";

	public var x:Float;
	public var y:Float;
	public var rotation:Float; // In radians
	public var width:Float;
	public var height:Float;

	public function new(?x:Float, ?y:Float, ?width:Float, ?height:Float) {
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
		this.rotation = 0;
	}

	public function getType():String {
		return type;
	}

	public function log(console:Console, ?color:Null<Int>):Void {
		console.log('x: $x', color);
		console.log('y: $y', color);
		console.log('width: $width', color);
		console.log('height: $height', color);
	}

	public function remove() {}
}
