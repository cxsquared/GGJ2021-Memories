package system;

import h2d.filter.Glow;
import component.Collidable;
import component.Renderable;

class FlashCollision implements IPerEntitySystem {
	public var forComponents:Array<String> = [Renderable.type, Collidable.type];

	public function new() {}

	public function update(entity:Entity, dt:Float) {
		var renderable:Renderable = cast entity.get(Renderable.type);
		var collidable:Collidable = cast entity.get(Collidable.type);

		if (renderable.bitmap.filter == null) {
			renderable.bitmap.filter = new Glow(0x00FF00, 1);
		}

		if (Std.isOfType(renderable.bitmap.filter, Glow)) {
			var filter:Glow = cast renderable.bitmap.filter;

			if (collidable.colliding) {
				filter.color = 0xFF0000;
			} else {
				filter.color = 0x00FF00;
			}
		}
	}
}
