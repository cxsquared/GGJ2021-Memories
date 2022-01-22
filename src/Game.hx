import scenes.CollisionTest;
import hxd.Key;
import scenes.GameScene;
import scenes.Pong;

class Game extends hxd.App {
	var scene:GameScene;

	public function new() {
		super();
	}

	override function init() {
		hxd.Res.initEmbed();
		setGameScene(new Pong(s2d));
	}

	public function setGameScene(gs:GameScene) {
		if (scene != null) {
			s2d.removeChild(scene); // This might not actually clean anything up aka memory leak
		}

		scene = gs;

		scene.init();
	}

	override function update(dt:Float) {
		if (Key.isPressed(Key.R))
			setGameScene(new Pong(s2d));

		if (scene != null)
			scene.update(dt);
	}
}
