package component;

import h2d.Console;

class Bounce implements IComponent {
	public static final type = "Bounce";

	public var speed = 8;
	public var amplitude:Float = .1;

	public function new() {}

	public function getType():String {
		return type;
	}

	public function log(console:Console, ?color:Int) {}

	public function remove() {}
}
