package system;

import hxd.Math;
import component.Velocity;
import component.Transform;

class RandomMove implements IPerEntitySystem {
	public var forComponents:Array<String> = [Transform.type, Velocity.type];

	var directionTick = 0;

	public function new() {}

	public function update(entity:Entity, dt:Float) {
		var transform:Transform = cast entity.get(Transform.type);
		var velocity:Velocity = cast entity.get(Velocity.type);

		if ((directionTick++ % entity.id) == 0) {
			velocity.dx = Math.srand(50);
			velocity.dy = Math.srand(50);
		}

		transform.x += velocity.dx * dt;
		transform.y += velocity.dy * dt;
	}
}
