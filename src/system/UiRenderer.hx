package system;

import component.Ui;
import component.Transform;
import component.Renderable;
import component.Camera;

class UiRenderer implements IPerEntitySystem {
	public var forComponents:Array<String> = [Ui.type, Transform.type];

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

		renderable.drawable.setPosition(position.x, position.y);
		renderable.drawable.rotation = transform.rotation;
	}
}
