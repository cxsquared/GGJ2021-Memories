package component;

import h2d.Object;
import hxd.Event;
import h2d.Console;
import h2d.Interactive;

class Button implements IComponent {
	public static final type = "Button";

	public var interaction:Interactive;
	public var isClicked:Bool = false;

	public function new(parent:Object, width:Float, height:Float) {
		interaction = new h2d.Interactive(width, height, parent);
		interaction.onClick = function(event:hxd.Event) {
			isClicked = true;
		}
	}

	public function getType():String {
		return type;
	}

	public function log(console:Console, ?color:Int) {}

	public function remove() {
		this.interaction.remove();
	}
}
