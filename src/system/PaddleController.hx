package system;

import hxd.Key;
import component.Velocity;
import component.Transform;
import component.Paddle;

class PaddleController implements IPerEntitySystem {
	public var forComponents:Array<String> = [Paddle.type, Transform.type, Velocity.type];

	public function new() {}

	public function update(entity:Entity, dt:Float) {
		var p:Paddle = cast(entity.get(Paddle.type), Paddle);
		var t:Transform = cast(entity.get(Transform.type), Transform);
		var v:Velocity = cast(entity.get(Velocity.type), Velocity);

		if (p.player == 1) {
			if (Key.isDown(Key.W))
				v.dy = up(v, p, dt);

			if (Key.isDown(Key.S))
				v.dy = down(v, p, dt);
		}

		if (p.player == 2) {
			if (Key.isDown(Key.UP))
				v.dy = up(v, p, dt);

			if (Key.isDown(Key.DOWN))
				v.dy = down(v, p, dt);
		}

		v.dy *= p.friction;
		t.y += v.dy * dt;

		if (t.y > p.maxY)
			t.y = p.maxY;

		if (t.y < p.minY)
			t.y = p.minY;
	}

	function up(v:Velocity, p:Paddle, dt:Float) {
		return Math.max(v.dy - p.accel, -p.speed);
	}

	function down(v:Velocity, p:Paddle, dt:Float) {
		return Math.min(v.dy + p.accel, p.speed);
	}
}
