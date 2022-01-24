package system;

import scenes.Exploration;
import component.BookStand;
import hxd.Key;
import component.Player;
import component.Collidable;
import component.Glow;

typedef BookInteracted = () -> Void;

class BookStandController implements IPerEntitySystem {
	public var forComponents:Array<String> = [BookStand.type, Collidable.type];

	var bookInteracted:BookInteracted;

	public function new(bookInteracted:BookInteracted) {
		this.bookInteracted = bookInteracted;
	}

	public function update(entity:Entity, dt:Float) {
		if (Exploration.dialogueShowing)
			return;

		var c:Collidable = cast entity.get(Collidable.type);
		var g:Glow = cast entity.get(Glow.type);

		if (c.colliding && c.event.target.has(Player.type)) {
			if (Key.isPressed(Key.SPACE)) {
				bookInteracted();
			}
			g.glowing = true;
		} else {
			g.glowing = false;
		}
	}
}
