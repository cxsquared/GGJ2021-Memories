package system;

import component.Shake;
import component.Transform;

class Shaker implements IPerEntitySystem {
	public var forComponents:Array<String> = [Shake.type, Transform.type];

	public function new() {}

	public function update(entity:Entity, dt:Float) {
		var s:Shake = cast entity.get(Shake.type);
		var t:Transform = cast entity.get(Transform.type);

		if (s.currentTime <= s.length) {
			s.currentTime += dt;

			t.x += s.distance * Math.sin(s.currentTime * s.speed);
		}
	}
}
