import hxd.Key;
import scenes.GameScene;
import scenes.*;

class Game extends hxd.App {
	var scene:GameScene;

	public function new() {
		super();
	}

	override function init() {
		hxd.Res.initEmbed();
		setGameScene(new Exploration(s2d));
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
