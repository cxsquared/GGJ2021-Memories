package component;

import h2d.Console;

class Shake implements IComponent {
	public static final type = "Shake";

	public var length:Float = 2;
	public var distance:Float = .125;
	public var speed:Float = 12;
	public var currentTime:Float = 0;

	public function new() {
		currentTime = length;
	}

	public function getType():String {
		return type;
	}

	public function isShaking():Bool {
		return currentTime <= length;
	}

	public function log(console:Console, ?color:Int) {}

	public function remove() {}
}
