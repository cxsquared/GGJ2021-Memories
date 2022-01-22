package component;

import h2d.Console;
import h2d.Tile;

class Background implements IComponent {
	public static final type = "Background";

	public var tile:Tile;

	public function new(tile:Tile) {
		this.tile = tile;
	}

	public function getType():String {
		return type;
	}

	public function log(console:Console, ?color:Int) {}
}
