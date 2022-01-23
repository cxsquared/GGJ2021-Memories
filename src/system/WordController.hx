package system;

import component.Camera;
import component.Player;
import component.Collidable;
import component.Transform;
import component.Word;

using tweenxcore.Tools;

class WordController implements IPerEntitySystem {
	public var forComponents:Array<String> = [Word.type, Transform.type];

	public var tick:Float = 0;

	public function new() {}

	public function update(entity:Entity, dt:Float) {
		var w:Word = cast entity.get(Word.type);
		var t:Transform = cast entity.get(Transform.type);

		w.duration += dt;
		var rate = MathUtils.normalizeToOne(w.duration, 0, w.timeToTarget);
		if (rate <= 1) {
			t.x = rate.quadIn().lerp(w.start.x, w.target.x);
			t.y = rate.quadIn().lerp(w.start.y, w.target.y);
			t.rotation = rate.linear().lerp(0, 2 * Math.PI);
		}

		if (entity.has(Collidable.type)) {
			var c:Collidable = cast entity.get(Collidable.type);
			if (c.colliding && rate >= 1) {
				var target = c.event.target;

				if (target.has(Player.type)) {
					Game.memories.pickedUpWords.push(w.word);
					entity.remove();
				}
			}
		}
	}
}
