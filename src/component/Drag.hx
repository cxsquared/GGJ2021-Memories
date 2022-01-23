package component;

import hxd.Event;
import h2d.Console;
import h2d.Interactive;
import h2d.col.Collider;

class Drag implements IComponent {
	public static final type = "Drag";
	public var interaction:Interactive;
	public var isDragging:Bool = false;

	public function new(collider:Collider) {
		interaction = new h2d.Interactive(100, 100, null, collider);
		interaction.backgroundColor = 128;
		interaction.focus();
		interaction.onPush  = function(event : hxd.Event) {
			isDragging = true;
		}
		interaction.onClick  = function(event : hxd.Event) {
			isDragging = true;
		}
		// This is bad and I feel bad, but it works?
		/*function OnClick(event : hxd.Event) {
			if(event.kind.match(EventKind.EPush)){
				isDragging = true;
			}
			if(event.kind.match(EventKind.ERelease)){
				isDragging = false;
			}
		}
		hxd.Window.getInstance().addEventTarget(OnClick);*/
	}

	public function getType():String {
		return type;
	}

	public function log(console:Console, ?color:Int) {}

	public function remove() {}
}
