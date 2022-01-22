package component;

import h2d.Console;

class Velocity implements IComponent {
	public static final type = "Velocity";

	public var dx:Float;
	public var dy:Float;

	public function new(?dx:Float = 0, ?dy:Float = 0) {
		this.dx = dx;
		this.dy = dy;
	}

	public function getType():String {
		return type;
	}

	public function log(console:Console, ?color:Null<Int>):Void {
		console.log('dx: $dx', color);
		console.log('dy: $dy', color);
	}
}
