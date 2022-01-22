package system;

import h2d.Console;
import component.Camera;
import component.Player;
import component.Collidable;
import component.Transform;
import component.Drag;
import component.Word;

using tweenxcore.Tools;

class DragController implements IPerEntitySystem {
	public var forComponents:Array<String> = [Drag.type, Transform.type, Collidable.type, Word.type];

	public var cameraTransform:Transform;
	public var camera:Camera;
	public var tick:Float = 0;

	public function new(camera:Entity) {
		this.camera = cast camera.get(Camera.type);
		this.cameraTransform = cast camera.get(Transform.type);
	}

	public function update(entity:Entity, dt:Float) {
		var d:Drag = cast entity.get(Drag.type);
		var t:Transform = cast entity.get(Transform.type);
		var w:Word = cast entity.get(Word.type);
		d.interaction.x = t.x;
		d.interaction.y = t.y;

		if (d.isClicked){
			d.isClicked = false;
			w.word.text = "O:IJEFWO:JIFWO:";
		}
	}
}
