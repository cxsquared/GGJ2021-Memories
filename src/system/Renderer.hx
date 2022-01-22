package system;

import component.Transform;
import component.Renderable;

class Renderer implements IPerEntitySystem {
	public var forComponents:Array<String> = [Renderable.type, Transform.type];

	public function new() {}

	public function update(entity:Entity, dt:Float) {
		var renderable:Renderable = cast entity.get(Renderable.type);
		var transform:Transform = cast entity.get(Transform.type);

		renderable.bitmap.setPosition(transform.x, transform.y);
	}
}
