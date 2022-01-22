package scenes;

import system.PlayerController;
import component.Velocity;
import component.Camera;
import hxd.res.DefaultFont;
import h2d.Console;
import component.Transform;
import component.Player;
import system.CameraController;
import system.Renderer;
import h2d.Bitmap;
import component.Renderable;
import h2d.Tile;
import component.Background;
import h2d.Scene;
import hxd.Res;

class Exploration extends GameScene {
	var world = new World();
	var console:Console;

	public function new(scene:Scene) {
		super(scene);
	}

	override function init() {
		var s2d = getScene();

		console = new Console(DefaultFont.get(), this);

		var bgTile = Res.tempbackground.toTile();
		world.newEntity().add(new Transform()).add(new Renderable(new Bitmap(bgTile, this)));

		var player = world.newEntity()
			.add(new Player())
			.add(new Renderable(new Bitmap(Tile.fromColor(0xFF00FF, 32, 32), this)))
			.add(new Transform(0, 0, 32, 32))
			.add(new Velocity());

		world.newEntity().add(new Camera(player, this));

		world.addSystem(new PlayerController());
		world.addSystem(new CameraController(s2d, console));
		world.addSystem(new Renderer());
	}

	override function update(dt:Float) {
		world.update(dt);
	}
}
