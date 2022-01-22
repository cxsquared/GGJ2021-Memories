package system;

import system.IAllEntitySystem.IAllEntitySystems;
import component.Transform;
import component.Bounce;

class Bouncer implements IAllEntitySystems {
	var tick:Float = 0;

	public var forComponents:Array<String> = [Bounce.type, Transform.type];

	public function new() {}

	public function updateAll(entities:Array<Entity>, dt:Float) {
		tick += dt;

		for (entity in entities) {
			var bounce:Bounce = cast entity.get(Bounce.type);
			var transform:Transform = cast entity.get(Transform.type);

			transform.y += bounce.amplitude * Math.sin(bounce.speed * tick);
		}
	}
}
