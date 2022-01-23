package component;

import h2d.Console;

class Tree implements IComponent {
	public static final type = "Tree";

	public var spawnDelay = 3;
	public var timeTillCanSpawn:Float = 0;

	public function new() {}

	public function getType():String {
		return type;
	}

	public function log(console:Console, ?color:Int) {}

	public function remove() {}
}
