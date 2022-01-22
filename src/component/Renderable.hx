package component;

import h2d.Console;
import h2d.Bitmap;

class Renderable implements IComponent {
	public static final type = "Renderable";

	public var bitmap(default, null):Bitmap;

	public function new(bitmap:Bitmap) {
		this.bitmap = bitmap;
	}

	public function getType():String {
		return type;
	}

	public function log(console:Console, ?color:Null<Int>):Void {
		console.log(' tile: ${bitmap.tile.toString()}', color);
	}
}
