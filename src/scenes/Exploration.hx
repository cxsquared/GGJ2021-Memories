package scenes;

import hxd.Key;
import hxd.Math;
import component.Tree;
import system.TreeController;
import system.Collision;
import system.CollisionDebug;
import h3d.shader.Outline;
import system.WordController;
import h3d.shader.Parallax;
import component.Collidable;
import component.Word;
import h2d.Text;
import h2d.col.Bounds;
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

		var bgTile = Res.tempbackground.toTile();
		world.newEntity().add(new Transform()).add(new Renderable(new Bitmap(bgTile, this)));

		var player = world.newEntity()
			.add(new Player())
			.add(new Collidable(CollisionShape.CIRCLE, 15))
			.add(new Renderable(new Bitmap(Tile.fromColor(0xFF00FF, 32, 32), this)))
			.add(new Transform(0, 0, 32, 32))
			.add(new Velocity());

		var camera = world.newEntity()
			.add(new Camera(player, Bounds.fromValues(0, 0, 1000, 1000), s2d.width / 2, s2d.height / 2))
			.add(new Transform())
			.add(new Velocity());

		var tree = hxd.Res.temptree.toTile();
		tree.scaleToSize(32, 64);
		world.newEntity()
			.add(new Tree())
			.add(new Transform(Math.random(s2d.width), Math.random(s2d.height), 16, 64))
			.add(new Collidable(CollisionShape.CIRCLE, 30))
			.add(new Renderable(new Bitmap(tree, this)));

		world.addSystem(new PlayerController());
		world.addSystem(new Collision());
		world.addSystem(new TreeController(spawnWord));
		world.addSystem(new WordController(camera));
		world.addSystem(new Renderer(camera));
		world.addSystem(new CollisionDebug(camera, this));

		console = new Console(DefaultFont.get(), this);
		console.addCommand("debug", "", [], function() {
			world.debugLog(console);
		});

		world.addSystem(new CameraController(s2d, console));
	}

	override function update(dt:Float) {
		#if debug
		if (Key.isPressed(Key.PGDOWN)) {
			Game.memories.getCurrentMemory().advanceLine();
		}
		if (Key.isPressed(Key.NUMBER_1)) {
			var line = Game.memories.getCurrentMemory().getCurrentLine();
			console.log(line);
		}
		#end
		world.update(dt);
	}

	function spawnWord(x:Float, y:Float, word:String) {
		var word = Game.memories.getCurrentMemory().getWord();

		if (word == null) {
			return;
		}

		world.newEntity()
			.add(new Word(word.text, this))
			.add(new Transform(x, y, 0, 0))
			.add(new Collidable(CollisionShape.CIRCLE, 15));
	}
}
