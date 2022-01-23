package system;

import scenes.Exploration;
import hxd.Math;
import component.Velocity;
import component.Transform;
import hxd.Key;
import component.Player;

class PlayerController implements IPerEntitySystem {
	public var forComponents:Array<String> = [Player.type, Velocity.type, Transform.type];

	public function new() {}

	public function update(entity:Entity, dt:Float) {
		if (Exploration.dialogueShowing)
			return;

		var up = Key.isDown(Key.UP) || Key.isDown(Key.W);
		var left = Key.isDown(Key.LEFT) || Key.isDown(Key.A);
		var right = Key.isDown(Key.RIGHT) || Key.isDown(Key.D);
		var down = Key.isDown(Key.DOWN) || Key.isDown(Key.S);

		var t:Transform = cast entity.get(Transform.type);
		var v:Velocity = cast entity.get(Velocity.type);
		var p:Player = cast entity.get(Player.type);

		if (up)
			v.dy -= p.accel;

		if (down)
			v.dy += p.accel;

		if (left)
			v.dx -= p.accel;

		if (right)
			v.dx += p.accel;

		v.dx = Math.clamp(v.dx * v.friction, -p.maxSpeed, p.maxSpeed);
		v.dy = Math.clamp(v.dy * v.friction, -p.maxSpeed, p.maxSpeed);

		t.x += v.dx * dt;
		t.y += v.dy * dt;
	}
}
