package scenes;

import system.UiRenderer;
import component.Ui;
import h2d.col.Point;
import h2d.Console;
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
import h2d.Scene;
import hxd.Res;
import component.Renderable;
import h2d.Bitmap;

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
		var window = Window.getInstance();
		var bgTile = Res.bookbackground.toTile();
		var bitmap = new Bitmap(bgTile, this);
		bitmap.width = window.width;
		bitmap.height = window.height;
		world.newEntity("bookbackground").add(new Transform()).add(new Renderable(bitmap));

		world.addSystem(new DragController(s2d));
		world.addSystem(new Bouncer());
		world.addSystem(new WordController());
		world.addSystem(new UiRenderer());
		
		spawnMemory();
		spawnWords();
	}

	override function update(dt:Float) {
		world.update(dt);
	}

	function spawnMemory(){
		var memory = Game.memories.getCurrentMemory();
		var lineNumber = 0;
		var xCoordinate = 45;
		var yCoordinate = 0.0;
		for (line in memory.displayLines) {
			var text = new Text(DefaultFont.get(), this);
			var textHeight = text.textHeight * text.scaleY * 2;
			yCoordinate = lineNumber * textHeight + 35;
			var target = new Point(xCoordinate, yCoordinate);
			text.text = line;
			text.setScale(1.5);
			text.textColor = 0x000000;
			world.newEntity()
				.add(new Word(new memories.Word(line, null), new Point(0,0), target))
				.add(new Ui(text))
				.add(new Transform(x, y, text.calcTextWidth(line) * text.scaleX, text.textHeight * text.scaleY))
				.add(new Bounce());
			lineNumber++;
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
			var text = new Text(DefaultFont.get(), this);
			text.text = word.text;
			text.setScale(2);
			text.textColor = Std.int(Math.random() * 0xffffff);
			var start = new Point(x, y);
			var validWidth = width - (width / 2);
			var target = new Point(Math.srand(validWidth) + validWidth, (height / 2) + Math.srand(height / 2));
			world.newEntity()
				.add(new Word(word, start, target))
				.add(new Ui(text))
				.add(new Transform(x, y, text.calcTextWidth(word.text) * text.scaleX, text.textHeight * text.scaleY))
				.add(new Bounce())
				.add(new Drag(this, text.calcTextWidth(word.text) * text.scaleX, text.textHeight * text.scaleY));
		}
	}
}
