package system;

import memories.MemoryManager;
import scenes.Exploration;
import component.Transform;
import component.Button;
import h2d.Scene;

using tweenxcore.Tools;

class ButtonController implements IPerEntitySystem {
	public var forComponents:Array<String> = [Button.type, Transform.type];

	var scene:Scene;
	public function new(scene:Scene) {
		this.scene = scene;
	}

	public function update(entity:Entity, dt:Float) {
		var b:Button = cast entity.get(Button.type);
		
		var t:Transform = cast entity.get(Transform.type);
		if (b.isClicked) {
			Game.memories.finishCurrentMemory();
			Game.memories.setRandomMemory();
			Game.memories.pickedUpWords = new Array<memories.Word>();
			Game.game.setGameScene(new Exploration(scene));
		}
	}
}
