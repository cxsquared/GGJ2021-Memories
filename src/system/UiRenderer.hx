package system;

import component.Ui;
import component.Transform;

class UiRenderer implements IPerEntitySystem {
	public var forComponents:Array<String> = [Ui.type, Transform.type];

	public function new() {}

	public function update(entity:Entity, dt:Float) {
		var renderable:Ui = cast entity.get(Ui.type);
		var transform:Transform = cast entity.get(Transform.type);

		renderable.drawable.setPosition(transform.x, transform.y);
		renderable.drawable.rotation = transform.rotation;
	}
}
