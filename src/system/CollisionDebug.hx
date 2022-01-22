package system;

import hxd.Key;
import h2d.Object;
import system.IAllEntitySystem.IAllEntitySystems;
import component.Collidable;
import h2d.Graphics;

class CollisionDebug implements IAllEntitySystems {
	public var forComponents:Array<String> = [Collidable.type];

	var graphics = new Graphics();

	public function new(?parent:Object) {
		graphics = new Graphics(parent);
	}

	public function update(entity:Entity, dt:Float) {}

	public function updateAll(entities:Array<Entity>, dt:Float) {
		var toggle = false;
		if (Key.isPressed(Key.F1)) {
			toggle = true;
		}

		graphics.clear();
		graphics.beginFill(0x000000);

		for (e in entities) {
			var collidable:Collidable = cast e.get(Collidable.type);
			if (toggle) {
				collidable.debug = !collidable.debug;
			}

			if (collidable.debug) {
				graphics.setColor(collidable.debugColor, .75);
				switch (collidable.shape) {
					case CIRCLE:
						var circle = collidable.circle;
						graphics.drawCircle(circle.x, circle.y, circle.ray);

					case BOUNDS:
						var bounds = collidable.bounds;
						graphics.drawRect(bounds.x, bounds.y, bounds.width, bounds.height);
				}
			}
		}

		graphics.endFill();
	}
}
