package system;

import h2d.Console;
import component.Camera;
import component.Player;
import component.Collidable;
import component.Transform;
import component.Drag;
import component.Word;
import h2d.Scene;

using tweenxcore.Tools;

class DragController implements IPerEntitySystem {
	public var forComponents:Array<String> = [Drag.type, Transform.type, Collidable.type, Word.type];

	public var cameraTransform:Transform;
	public var camera:Camera;
	public var tick:Float = 0;
	var scene:Scene;

	public function new(camera:Entity, scene:Scene) {
		this.camera = cast camera.get(Camera.type);
		this.cameraTransform = cast camera.get(Transform.type);
		this.scene = scene;
	}

	public function update(entity:Entity, dt:Float) {
		var d:Drag = cast entity.get(Drag.type);
		var t:Transform = cast entity.get(Transform.type);
		var w:Word = cast entity.get(Word.type);
		d.interaction.x = t.x;
		d.interaction.y = t.y;

		if (d.isDragging){
			w.word.text = "O:IJEFWO:JIFWO:";
			t.x = scene.mouseX;
			t.y = scene.mouseY;
		}
	}
}
