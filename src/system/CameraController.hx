package system;

import h2d.col.Point;
import component.Velocity;
import h2d.Scene;
import hxd.Math;
import h2d.Console;
import component.Transform;
import component.Camera;

class CameraController implements IPerEntitySystem {
	public var forComponents:Array<String> = [Camera.type, Transform.type, Velocity.type];

	var console:Console;
	var scene:Scene;
	var hxCamera:h2d.Camera;

	public function new(scene:Scene, console:Console) {
		this.console = console;
		this.scene = scene;
		hxCamera = new h2d.Camera(scene);
		scene.addCamera(hxCamera);
	}

	public function update(entity:Entity, dt:Float) {
		var t:Transform = cast entity.get(Transform.type);
		var v:Velocity = cast entity.get(Velocity.type);
		var camera:Camera = cast entity.get(Camera.type);
		var target = camera.target;

		if (target == null)
			return;

		if (!target.has(Transform.type)) {
			console.log("Camera target must have a Transform component");
			return;
		}

		var targetTransform = cast target.get(Transform.type);

		// Follow target entity
		var cameraPoint = new Point(t.x, t.y);
		var targetPoint = new Point(targetTransform.x + targetTransform.width / 2, targetTransform.y + targetTransform.height / 2);

		var d = cameraPoint.distance(targetPoint);
		if (d >= camera.deadzone) {
			var angle = Math.atan2(targetPoint.y - cameraPoint.y, targetPoint.x - cameraPoint.x);

			v.dx += Math.cos(angle) * (d - camera.deadzone) * camera.speed * dt;
			v.dy += Math.sin(angle) * (d - camera.deadzone) * camera.speed * dt;
		}

		// Movements
		t.x += v.dx;
		v.dx *= v.friction * dt;

		t.y += v.dy;
		v.dy *= v.friction * dt;
	}
}
