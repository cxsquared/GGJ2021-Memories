package system;

import hxd.Rand;
import hxd.Math;
import hxd.Key;
import component.Player;
import component.Transform;
import component.Collidable;
import component.Tree;

typedef TreeCollisionCallback = (x:Float, y:Float, word:String) -> Void;

class TreeController implements IPerEntitySystem {
	public var forComponents:Array<String> = [Tree.type, Collidable.type, Transform.type];

	public var treeCollisionCallback:TreeCollisionCallback;

	public function new(treeCollisionCallback:TreeCollisionCallback) {
		this.treeCollisionCallback = treeCollisionCallback;
	}

	public function update(entity:Entity, dt:Float) {
		var transform:Transform = cast entity.get(Transform.type);
		var c:Collidable = cast entity.get(Collidable.type);

		if (c.colliding && c.event.target.has(Player.type) && Key.isPressed(Key.SPACE)) {
			treeCollisionCallback(Math.srand(25) + transform.x, Math.srand(25) + transform.y, "word");
		}
	}
}
