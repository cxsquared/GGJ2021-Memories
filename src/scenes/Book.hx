package scenes;

import system.UiRenderer;
import component.Ui;
import h2d.col.Point;
import h2d.Console;
import h2d.Scene;
import hxd.res.DefaultFont;
import h2d.Text;
import hxd.Math;
import hxd.Window;
import component.Word;
import component.Madlib;
import component.Bounce;
import component.Drag;
import system.Bouncer;
import system.WordController;
import system.DragController;
import component.Transform;
import component.Velocity;

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

		world.addSystem(new DragController(s2d));
		world.addSystem(new Bouncer());
		world.addSystem(new WordController());
		world.addSystem(new UiRenderer());
		spawnWords();
	}

	override function update(dt:Float) {
		world.update(dt);
	}

	function spawnMemory(){
		var memories = Game.memories.memories;
		var window = Window.getInstance();
		var width = window.width;
		var height = window.height;
		for (memory in memories)
		{
			for (line in memory.lines) {
				var x = 1000;
				var y = 1000;
				var start = new Point(x, y);
				var target = new Point(Math.srand(width / 2) + (width / 2), Math.srand(height / 2) + (height / 2));
				var text = new Text(DefaultFont.get(), this);
				text.text = line;
				text.setScale(2);
				text.textColor = Std.int(Math.random() * 0xffffff);
				world.newEntity()
					.add(new Word(new memories.Word(line, null), start, target))
					.add(new Ui(text))
					.add(new Transform(x, y, text.calcTextWidth(line) * text.scaleX, text.textHeight * text.scaleY))
					.add(new Bounce());
			}
		}
	}

	function spawnWords() {
		var words = Game.memories.pickedUpWords;

		if (words == null) {
			return;
		}

		var window = Window.getInstance();
		var width = window.width;
		var height = window.height;
		for (word in words) {
			console.log(word.text);
			var text = new Text(DefaultFont.get(), this);
			text.text = word.text;
			text.setScale(2);
			text.textColor = Std.int(Math.random() * 0xffffff);
			var x = 1000;
			var y = 1000;
			var start = new Point(x, y);
			var target = new Point(Math.srand(width / 2) + (width / 2), Math.srand(height / 2) + (height / 2));
			world.newEntity()
				.add(new Word(word, start, target))
				.add(new Ui(text))
				.add(new Transform(x, y, text.calcTextWidth(word.text) * text.scaleX, text.textHeight * text.scaleY))
				.add(new Bounce())
				.add(new Drag(this, text.calcTextWidth(word.text) * text.scaleX, text.textHeight * text.scaleY));
		}
	}
}
