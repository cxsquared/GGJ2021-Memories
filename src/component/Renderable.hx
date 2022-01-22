package component;

import h2d.Drawable;
import h2d.Console;

class Renderable implements IComponent {
	public static final type = "Renderable";

	public var drawable(default, null):Drawable;

	public function new(drawable:Drawable) {
		this.drawable = drawable;
	}

	public function getType():String {
		return type;
	}

	public function log(console:Console, ?color:Null<Int>):Void {
		console.log(' tile: ${drawable.name}', color);
	}

	public function remove() {
		this.drawable.remove();
	}
}
