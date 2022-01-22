package component;

import h2d.Console;

class Madlib implements IComponent {
	public static final type = "Madlib";


	public function new() {}

	public function getType():String {
		return type;
	}

	public function log(console:Console, ?color:Int) {}

	public function remove() {}
}
