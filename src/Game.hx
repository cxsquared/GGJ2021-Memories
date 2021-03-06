import format.abc.Data.ABCData;
import h2d.Scene.ScaleMode;
import memories.Word;
import memories.MemoryManager;
import memories.MemoryDeserializer;
import haxe.Json;
import scenes.GameScene;
import scenes.*;
import hxd.Key;
import scenes.SplashScreen;

class Game extends hxd.App {
	var scene:GameScene;

	public static var game:Game;
	public static var memories:MemoryManager;

	public function new() {
		super();
		game = this;
	}

	override function init() {
		s2d.scaleMode = ScaleMode.Fixed(800, 600, 1);
		hxd.Res.initEmbed();
		var memoryText = hxd.Res.memories.entry.getText();
		var memoryFile = Json.parse(memoryText);
		memories = new MemoryManager(MemoryDeserializer.deserializeMemoryJson(memoryFile));
		memories.setRandomMemory();

		#if debug
		memories.setMemory(1);
		#end

		setGameScene(new SplashScreen(s2d));
	}

	public function setGameScene(gs:GameScene) {
		if (scene != null) {
			s2d.removeChild(scene); // This might not actually clean anything up aka memory leak
		}

		scene = gs;

		scene.init();
	}

	override function update(dt:Float) {
		if (scene != null)
			scene.update(dt);
	}
}
