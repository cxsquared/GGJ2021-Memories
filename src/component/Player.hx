package component;

import h2d.Console;

class Player implements IComponent {
	public static final type = "Player";

	public var accel = 25;
	public var maxSpeed = 100;

	public function new() {}

	public function getType():String {
		return type;
	}

	public function log(console:Console, ?color:Int) {}
}
