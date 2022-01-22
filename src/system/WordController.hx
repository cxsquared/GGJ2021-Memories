package system;

import hxd.Math;
import hxd.Timer;
import component.Camera;
import component.Player;
import component.Collidable;
import component.Transform;
import component.Word;

class WordController implements IPerEntitySystem {
	public var forComponents:Array<String> = [Word.type, Transform.type, Collidable.type];

	public var cameraTransform:Transform;
	public var camera:Camera;
	public var tick:Float = 0;

	public function new(camera:Entity) {
		this.camera = cast camera.get(Camera.type);
		this.cameraTransform = cast camera.get(Transform.type);
	}

	public function update(entity:Entity, dt:Float) {
		var word:Word = cast entity.get(Word.type);
		var t:Transform = cast entity.get(Transform.type);
		var c:Collidable = cast entity.get(Collidable.type);

		var position = CameraUtils.worldToScreen(t, camera, cameraTransform);
		word.text.setPosition(position.x, Math.sin(tick += dt) * Math.random(5) + position.y);
		t.width = word.text.textWidth;
		t.height = word.text.textHeight;

		if (c.colliding) {
			var target = c.event.target;

			if (target.has(Player.type)) {
				entity.remove();
			}
		}
	}
}
