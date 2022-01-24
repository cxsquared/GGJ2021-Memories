package component;

import h2d.Console;

class Glow implements IComponent {
	public static final type = "Glow";

	public var glowing:Bool = false;
	public var color:Int;

	public function new(?color:Int = 0xffffff) {
		this.color = color;
	}

	public function getType():String {
		return type;
	}

	public function log(console:Console, ?color:Int) {}

	public function remove() {}
}
