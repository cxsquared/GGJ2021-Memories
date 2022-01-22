package component;

import h2d.Console;
import h2d.Interactive;
import h2d.Object;

class Drag implements IComponent {
	public static final type = "Drag";
	public var interaction:Interactive;
	public var isClicked:Bool = false;

	public function new() {
		interaction = new h2d.Interactive(500, 500);

		interaction.onClick = function(event : hxd.Event) {
			isClicked = true;
		}
	}

	public function getType():String {
		return type;
	}
	

	public function log(console:Console, ?color:Int) {}

	public function remove() {}
	
}
