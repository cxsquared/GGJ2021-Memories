package component;

import h2d.Object;
import h2d.Console;

class Camera implements IComponent {
	public static final type = "Camera";

	public var target:Entity;

	public function new(target:Entity, parent:Object) {
		this.target = target;
	}

	public function getType():String {
		return type;
	}

	public function log(console:Console, ?color:Int) {}
}
