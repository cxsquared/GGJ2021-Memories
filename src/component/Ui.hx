package component;

import h2d.Drawable;
import h2d.Console;

class Ui implements IComponent {
	public static final type = "Ui";

	public var drawable(default, null):Drawable;

	public function new(drawable:Drawable) {
		this.drawable = drawable;
	}

	public function getType():String {
		return type;
	}

	public function log(console:Console, ?color:Int) {}

	public function remove() {
		drawable.remove();
	}
}
