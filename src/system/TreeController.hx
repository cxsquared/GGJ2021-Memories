package system;

import component.Glow;
import scenes.Exploration;
import haxe.Timer;
import component.Shake;
import hxd.Key;
import component.Player;
import component.Transform;
import component.Collidable;
import component.Tree;

typedef TreeCollisionCallback = (x:Float, y:Float) -> Void;

class TreeController implements IPerEntitySystem {
	public var forComponents:Array<String> = [Tree.type, Collidable.type, Transform.type];

	public var treeCollisionCallback:TreeCollisionCallback;

	public function new(treeCollisionCallback:TreeCollisionCallback) {
		this.treeCollisionCallback = treeCollisionCallback;
	}

	public function update(entity:Entity, dt:Float) {
		if (Exploration.dialogueShowing)
			return;

		var transform:Transform = cast entity.get(Transform.type);
		var c:Collidable = cast entity.get(Collidable.type);
		var tree:Tree = cast entity.get(Tree.type);
		var s:Shake = cast entity.get(Shake.type);

		var isShaking = false;
		if (s != null) {
			isShaking = s.isShaking();
			if (isShaking)
				return;
		}

		tree.timeTillCanSpawn -= dt;

		if (c.colliding && c.event.target.has(Player.type) && !isShaking && tree.timeTillCanSpawn <= 0) {
			if (entity.has(Glow.type)) {
				var g:Glow = cast entity.get(Glow.type);

				g.glowing = true;
			}

			if (Key.isPressed(Key.SPACE)) {
				if (s != null) {
					s.currentTime = 0;
				}
				Timer.delay(function() {
					treeCollisionCallback(transform.x, transform.y);
					tree.timeTillCanSpawn = tree.spawnDelay;
				}, Std.int(s.length * 999));
			}
		}

		if (!c.colliding && entity.has(Glow.type)) {
			var g:Glow = cast entity.get(Glow.type);

			g.glowing = false;
		}
	}
}
