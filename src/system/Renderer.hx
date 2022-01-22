package system;

import h2d.col.Point;
import component.Transform;
import component.Renderable;
import component.Camera;

class Renderer implements IPerEntitySystem {
	public var forComponents:Array<String> = [Renderable.type, Transform.type];

	public var cameraTransform:Transform;
	public var camera:Camera;

	public function new(camera:Entity) {
		this.camera = cast camera.get(Camera.type);
		this.cameraTransform = cast camera.get(Transform.type);
	}

	public function update(entity:Entity, dt:Float) {
		var renderable:Renderable = cast entity.get(Renderable.type);
		var transform:Transform = cast entity.get(Transform.type);

		var position = CameraUtils.worldToScreen(transform, camera, cameraTransform);

		renderable.bitmap.setPosition(position.x, position.y);
	}
}
