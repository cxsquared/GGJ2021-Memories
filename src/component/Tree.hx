package component;

import h2d.Console;

class Tree implements IComponent {
	public static final type = "Tree";

	public function new() {}

	public function getType():String {
		return type;
	}

	public function log(console:Console, ?color:Int) {}

	public function remove() {}
}
