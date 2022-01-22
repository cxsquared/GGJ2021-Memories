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
		interaction = new h2d.Interactive(500, 500, collider);

		// This is bad and I feel bad, but it works?
		function OnClick(event : hxd.Event) {
			if(event.kind.match(EventKind.EPush)){
				isDragging = true;
			}
			if(event.kind.match(EventKind.ERelease)){
				isDragging = false;
			}
		}
		hxd.Window.getInstance().addEventTarget(OnClick);
	}

	public function getType():String {
		return type;
	}

	public function log(console:Console, ?color:Int) {}

	public function remove() {}
}
