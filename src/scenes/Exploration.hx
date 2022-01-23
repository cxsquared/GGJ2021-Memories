package scenes;

import h2d.Bitmap;
import system.DialogueController;
import system.UiRenderer;
import component.DialogueBox;
import component.Ui;
import h2d.Object;
import h2d.col.Point;
import component.Bounce;
import system.Bouncer;
import hxd.Key;
import hxd.Math;
import component.Tree;
import system.TreeController;
import system.Collision;
import system.CollisionDebug;
import system.WordController;
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
		world.newEntity("bg").add(new Transform()).add(new Renderable(new Bitmap(bgTile, this)));

		var player = world.newEntity("player")
			.add(new Player())
			.add(new Collidable(CollisionShape.CIRCLE, 15))
			.add(new Renderable(new Bitmap(Tile.fromColor(0xFF00FF, 32, 32), this)))
			.add(new Transform(0, 0, 32, 32))
			.add(new Velocity());

		var camera = world.newEntity("camera")
			.add(new Camera(player, Bounds.fromValues(0, 0, bgTile.width, bgTile.height), s2d.width / 2, s2d.height / 2))
			.add(new Transform())
			.add(new Velocity());

		var tree = hxd.Res.temptree.toTile();
		for (i in 0...25) {
			var width = Math.random(32) + 16;
			tree.scaleToSize(width, width * 2);
			world.newEntity('tree $i')
				.add(new Tree())
				.add(new Transform(Math.random(bgTile.width), Math.random(bgTile.height), 16, 64))
				.add(new Collidable(CollisionShape.CIRCLE, 30))
				.add(new Renderable(new Bitmap(tree, this)));
		}

		world.addSystem(new PlayerController());
		world.addSystem(new Collision());
		world.addSystem(new Bouncer());
		world.addSystem(new TreeController(spawnWord));
		world.addSystem(new WordController());
		world.addSystem(new DialogueController());
		world.addSystem(new Renderer(camera));
		world.addSystem(new UiRenderer());
		world.addSystem(new CollisionDebug(camera, this));

		console = new Console(DefaultFont.get(), this);
		console.addCommand("debug", "", [], function() {
			world.debugLog(console);
		});

		world.addSystem(new CameraController(s2d, console));

		makeDialogue(world, Game.memories.getCurrentMemory().getCurrentLine(), s2d, this);
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

		var text = new Text(DefaultFont.get(), this);
		text.text = word.text;
		text.setScale(2);
		text.textColor = Std.int(Math.random() * 0xffffff);
		var start = new Point(x, y);
		var target = new Point(Math.srand(45) + x, Math.srand(45) + y);

		world.newEntity('word: ${word.text}')
			.add(new Word(word, start, target))
			.add(new Renderable(text))
			.add(new Transform(x, y, text.textWidth, text.textHeight))
			.add(new Collidable(CollisionShape.CIRCLE, 15, 0, 0, 0x0000FF))
			.add(new Bounce());
	}

	function makeDialogue(world:World, text:String, s2d:Scene, parent:Object) {
		var bg = new h2d.ScaleGrid(hxd.Res.tempui.toTile(), 5, 5, parent);
		bg.width = s2d.width;
		bg.height = s2d.height / 4;
		bg.colorKey = 0xFF00FF;
		bg.color.a = 0.5;
		var tf = new h2d.Text(DefaultFont.get(), parent);
		tf.setScale(3);
		tf.y = s2d.height - tf.textHeight / 2;
		tf.x = s2d.width / 2 - tf.calcTextWidth(text) / 2;
		tf.maxWidth = s2d.width - s2d.width / 5;
		tf.dropShadow = {
			dx: 0,
			dy: 1,
			color: 0,
			alpha: 0.3
		};
		var bg = world.newEntity("dialogue background").add(new Transform(0, s2d.height - s2d.height / 4, s2d.width, s2d.height / 4)).add(new Ui(bg));
		world.newEntity("dialogue")
			.add(new Ui(tf))
			.add(new DialogueBox(text, 0xffffff, bg))
			.add(new Transform(tf.x, tf.y, tf.maxWidth, tf.textHeight));
	}
}
