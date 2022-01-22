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

		if (!target.has(Transform.type)) {
			console.log("Camera target must have a Transform component");
			return;
		}

		var targetTransform = cast target.get(Transform.type);

		// Follow target entity
		var s = 0.006;
		var deadZone = 5;
		var cameraPoint = new Point(t.x, t.y);
		var targetPoint = new Point(targetTransform.x, targetTransform.y);

		var d = cameraPoint.distance(targetPoint);
		if (d >= deadZone) {
			var a = Math.cameraPoint.ang;
			dx += Math.cos(a) * (d - deadZone) * s * tmod;
			dy += Math.sin(a) * (d - deadZone) * s * tmod;
		}

		// Movements
		var frict = 0.89;
		focus.levelX += dx * tmod;
		dx *= Math.pow(frict, tmod);

		focus.levelY += dy * tmod;
		dy *= Math.pow(frict, tmod);
	}
}
