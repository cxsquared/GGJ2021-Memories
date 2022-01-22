package scenes;

import h3d.shader.PointShadow;
import format.tgz.Data;
import component.Madlib;
import h2d.col.Point;
import h2d.Console;
import h2d.col.Collider;
import h2d.Scene;
import hxd.res.DefaultFont;
import h2d.Text;
import hxd.Math;
import hxd.Window;
import component.Word;
import component.Madlib;
import component.Renderable;
import component.Transform;
import component.Bounce;
import component.Drag;
import component.Collidable;
import system.Collision;
import system.Bouncer;
import system.WordController;
import component.Camera;
import system.Renderer;
import system.DragController;
import component.Transform;
import component.Velocity;
import system.CollisionDebug;
import h2d.col.Bounds;

class Book extends GameScene {
	var console:Console;
	var world = new World();
	
	public function new(scene:Scene) {
		super(scene);
	}

	override function init() {
		var s2d = getScene();
		console = new Console(DefaultFont.get(), this);
		console.addCommand("debug", "", [], function() {
			world.debugLog(console);
		});
		var madlib = world.newEntity("madlib")
			.add(new Madlib())
			.add(new Transform(0, 0, 32, 32))
			.add(new Velocity());

		var camera = world.newEntity("camera")
		.add(new Camera(madlib, Bounds.fromValues(0, 0, s2d.width, s2d.height), s2d.width / 2, s2d.height / 2))
		.add(new Transform(0,0, s2d.width/2, s2d.height/2))
		.add(new Velocity());

		world.addSystem(new Collision());
		world.addSystem(new Bouncer());
		world.addSystem(new WordController(camera));
		world.addSystem(new Renderer(camera));
		world.addSystem(new CollisionDebug(camera, this));
		world.addSystem(new DragController(camera));
		spawnWords();
	}

	override function update(dt:Float) {
		world.update(dt);
	}

	function spawnWords() {
		var words = Game.memories.pickedUpWords;

		if (words == null) {
			return;
		}

		console.log("Logging words!");
		var window = Window.getInstance();
		var width = window.width;
		var height = window.height;
		for (word in words){
			console.log(word.text);
			var text = new Text(DefaultFont.get(), this);
			text.text = word.text;
			text.setScale(2);
			text.textColor = Std.int(Math.random() * 0xffffff);
			var x = 1000;
			var y = 1000;
			var start = new Point(x, y);
			var target = new Point(Math.srand(width / 2) + (width / 2), Math.srand(height / 2) + (height / 2));
			var collider = new Collidable(CollisionShape.CIRCLE, 30, 0, 0, 0x0000FF);
			world.newEntity()
				.add(new Word(word, start, target))
				.add(new Renderable(text))
				.add(new Transform(x, y, text.textWidth, text.textHeight))
				.add(collider)
				.add(new Bounce())
				.add(new Drag());
		}
	}
}
