package system;

import component.Renderable;
import hxd.Key;
import component.Player;
import component.Collidable;
import component.Book;

typedef BookInteracted = () -> Void;

class BookController implements IPerEntitySystem {
	public var forComponents:Array<String> = [Book.type, Collidable.type];

	var bookInteracted:BookInteracted;

	public function new(bookInteracted:BookInteracted) {
		this.bookInteracted = bookInteracted;
	}

	public function update(entity:Entity, dt:Float) {
		var c:Collidable = cast entity.get(Collidable.type);

		if (c.colliding && c.event.target.has(Player.type) && Key.isPressed(Key.SPACE)) {
			bookInteracted();
		}
	}
}
