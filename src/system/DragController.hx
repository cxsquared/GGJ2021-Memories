package system;

import haxe.display.Display.Package;
import hxd.Key;
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
	public var forComponents:Array<String> = [Drag.type, Transform.type];

	var scene:Scene;

	public function new(scene:Scene) {
		this.scene = scene;
	}

	public function update(entity:Entity, dt:Float) {
		var d:Drag = cast entity.get(Drag.type);
		var t:Transform = cast entity.get(Transform.type);
		d.interaction.x = t.x;
		d.interaction.y = t.y;

		if (d.isDragging) {
			t.x = scene.mouseX - t.width / 2;
			t.y = scene.mouseY - t.height / 2;
		}
	}
}
