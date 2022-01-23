package component;

import h2d.Object;
import hxd.Event;
import h2d.Console;
import h2d.Interactive;

class Drag implements IComponent {
	public static final type = "Drag";

	public var interaction:Interactive;
	public var isDragging:Bool = false;

	public function new(parent:Object, width:Float, height:Float) {
		interaction = new h2d.Interactive(width, height, parent);
		interaction.onRelease = function(event:hxd.Event) {
			isDragging = false;
		}
		interaction.onReleaseOutside = function(event:hxd.Event) {
			isDragging = false;
		}
		interaction.onPush = function(event:hxd.Event) {
			isDragging = true;
		}
	}

	public function getType():String {
		return type;
	}

	public function log(console:Console, ?color:Int) {}

	public function remove() {}
}
