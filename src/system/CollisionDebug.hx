package system;

import component.Camera;
import hxsl.Cache;
import component.Transform;
import hxd.Key;
import h2d.Object;
import system.IAllEntitySystem.IAllEntitySystems;
import component.Collidable;
import h2d.Graphics;

class CollisionDebug implements IAllEntitySystems {
	public var forComponents:Array<String> = [Collidable.type];

	var graphics = new Graphics();

	public var cameraTransform:Transform;
	public var camera:Camera;

	public function new(camera:Entity, ?parent:Object) {
		graphics = new Graphics(parent);
		this.camera = cast camera.get(Camera.type);
		this.cameraTransform = cast camera.get(Transform.type);
	}

	public function update(entity:Entity, dt:Float) {}

	public function updateAll(entities:Array<Entity>, dt:Float) {
		var toggle = false;
		if (Key.isPressed(Key.F1)) {
			toggle = true;
		}

		graphics.clear();
		graphics.beginFill(0x000000);

		for (e in entities) {
			var collidable:Collidable = cast e.get(Collidable.type);
			if (toggle) {
				collidable.debug = !collidable.debug;
			}

			if (collidable.debug) {
				graphics.setColor(collidable.debugColor, .75);
				switch (collidable.shape) {
					case CIRCLE:
						var circle = collidable.circle;
						var point = CameraUtils.worldToScreen(new Transform(circle.x, circle.y), camera, cameraTransform);
						graphics.drawCircle(point.x, point.y, circle.ray);

					case BOUNDS:
						var bounds = collidable.bounds;
						var point = CameraUtils.worldToScreen(new Transform(bounds.x, bounds.y), camera, cameraTransform);
						graphics.drawRect(point.x, point.y, bounds.width, bounds.height);
				}
			}
		}

		graphics.endFill();
	}
}
