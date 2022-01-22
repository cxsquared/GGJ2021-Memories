package system;

import system.IAllEntitySystem.IAllEntitySystems;
import component.Collidable;
import component.Transform;

class Collision implements IAllEntitySystems {
	public var forComponents:Array<String> = [Collidable.type, Transform.type];

	public function new() {}

	public function updateAll(entities:Array<Entity>, dt:Float) {
		// Update all positions
		for (e in entities) {
			var ec:Collidable = cast e.get(Collidable.type);
			var et:Transform = cast e.get(Transform.type);
			switch (ec.shape) {
				case CIRCLE:
					ec.circle.x = et.x + et.width / 2;
					ec.circle.y = et.y + et.height / 2;
				case BOUNDS:
					ec.bounds.set(et.x, et.y, et.width, et.height);
			}
			ec.colliding = false;
			ec.event = null;
		}

		// check for collisions
		for (a in entities) {
			var ac:Collidable = cast a.get(Collidable.type);

			for (b in entities) {
				if (a.id == b.id)
					continue;

				var bc:Collidable = cast b.get(Collidable.type);

				if (overlaps(ac, bc)) {
					var event = new CollisionEvent(a, b);
					ac.colliding = true;
					ac.event = event;
					break;
				}
			}
		}
	}

	function overlaps(ac:Collidable, bc:Collidable):Bool {
		switch (ac.shape) {
			case CIRCLE:
				if (bc.shape == CIRCLE)
					return ac.circle.collideCircle(bc.circle);

				return ac.circle.collideBounds(bc.bounds);
			case BOUNDS:
				if (bc.shape == CIRCLE)
					return bc.circle.collideBounds(ac.bounds);

				return ac.bounds.intersects(bc.bounds);
		}

		return false;
	}
}
