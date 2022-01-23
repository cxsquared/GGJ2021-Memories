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

		world.addSystem(new DragController(s2d));
		world.addSystem(new Bouncer());
		world.addSystem(new WordController());
		world.addSystem(new UiRenderer());
		
		var meoryHeight = spawnMemory();
		spawnWords(meoryHeight);
	}

	override function update(dt:Float) {
		world.update(dt);
	}

	function spawnMemory() : Float{
		var memory = Game.memories.getCurrentMemory();
		var lineNumber = 0;
		var yCoordinate = 0.0;
		var color = Std.int(Math.random() * 0xffffff);
		for (line in memory.displayLines) {
			var text = new Text(DefaultFont.get(), this);
			var textHeight = text.textHeight * text.scaleY * 2;
			yCoordinate = lineNumber * textHeight;
			var target = new Point(0, yCoordinate);
			text.text = line;
			text.setScale(2);
			text.textColor = color;
			world.newEntity()
				.add(new Word(new memories.Word(line, null), new Point(0,0), target))
				.add(new Ui(text))
				.add(new Transform(x, y, text.calcTextWidth(line) * text.scaleX, text.textHeight * text.scaleY))
				.add(new Bounce());
			lineNumber++;
		}
		return yCoordinate;
	}

	function spawnWords(memoryHeight:Float) {
		var words = Game.memories.pickedUpWords;

		if (words == null) {
			return;
		}

		var window = Window.getInstance();
		var width = window.width;
		var height = window.height;
		for (word in words) {
			var text = new Text(DefaultFont.get(), this);
			text.text = word.text;
			text.setScale(2);
			text.textColor = Std.int(Math.random() * 0xffffff);
			var start = new Point(x, y);
			var validHeight = height - memoryHeight;
			var target = new Point(Math.srand(width / 2) + (width / 2), memoryHeight + Math.srand(validHeight / 2));
			world.newEntity()
				.add(new Word(word, start, target))
				.add(new Ui(text))
				.add(new Transform(x, y, text.calcTextWidth(word.text) * text.scaleX, text.textHeight * text.scaleY))
				.add(new Bounce())
				.add(new Drag(this, text.calcTextWidth(word.text) * text.scaleX, text.textHeight * text.scaleY));
		}
	}
}
