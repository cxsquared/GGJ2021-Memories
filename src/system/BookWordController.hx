package system;

import component.Player;
import component.Collidable;
import component.Transform;
import component.Word;

using tweenxcore.Tools;

class BookWordController implements IPerEntitySystem {
	public var forComponents:Array<String> = [Word.type, Transform.type, Collidable.type];


	public var tick:Float = 0;

	public function new() {	}

	public function update(entity:Entity, dt:Float) {
		var c:Collidable = cast entity.get(Collidable.type);
		var w:Word = cast entity.get(Word.type);
		var t:Transform = cast entity.get(Transform.type);

		w.duration += dt;
		var rate = MathUtils.normalizeToOne(w.duration, 0, w.timeToTarget);
		if (rate <= 1) {
			t.x = rate.quadIn().lerp(w.start.x, w.target.x);
			t.y = rate.quadIn().lerp(w.start.y, w.target.y);
			t.rotation = rate.linear().lerp(0, 2 * Math.PI);
		}

		if (c.colliding) {
			var target = c.event.target;

			if (target.has(Player.type)) {
				Game.memories.pickedUpWords.push(w.word);
				entity.remove();
			}
		}
	}
}
