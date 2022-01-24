package scenes;

import memories.Memory;
import system.BookStandController;
import h2d.Layers;
import component.BookStand;
import system.Shaker;
import component.Shake;
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
import h2d.Scene;
import hxd.Res;

class Exploration extends GameScene {
	var world = new World();
	var console:Console;
	var s2d:Scene;
	var layer:Layers;

	public static var dialogueShowing = false;

	public function new(scene:Scene) {
		super(scene);
	}

	override function init() {
		s2d = getScene();
		layer = new Layers(this);

		var wide = 2;
		var tall = 2;
		var bgTile = Res.bg.toTile();
		var worldWidth = wide * bgTile.width;
		var worldHeight = tall * bgTile.height;
		for (x in 0...wide) {
			for (y in 0...tall) {
				world.newEntity("bg")
					.add(new Transform(x * bgTile.width, y * bgTile.height, bgTile.width, bgTile.height))
					.add(new Renderable(new Bitmap(bgTile, layer)));
			}
		}

		var bookX = Math.srand(100);
		bookX += bookX > 0 ? 100 : -100;
		var bookY = Math.srand(100);
		bookY += bookY > 0 ? 100 : -100;

		var bookSpawn = new Point(bookX + worldWidth / 2, bookY + worldHeight / 2);
		var bookStand = new Bitmap(hxd.Res.bookstand.toTile());
		layer.add(bookStand, 1);
		bookStand.colorKey = 0xff00ff;
		bookStand.setScale(.2);
		var bookSize = bookStand.getSize();
		var bookCollision = new Collidable(BOUNDS, 0, bookSize.width / 2, bookSize.height);
		bookCollision.offsetX = bookSize.width / 4;
		world.newEntity("book stand")
			.add(new BookStand())
			.add(new Renderable(bookStand))
			.add(bookCollision)
			.add(new Transform(bookSpawn.x, bookSpawn.y, bookStand.getSize().width, bookStand.getSize().height));

		var tree01 = hxd.Res.tree01.toTile();
		var tree02 = hxd.Res.tree02.toTile();
		var tree03 = hxd.Res.tree03.toTile();
		var tree04 = hxd.Res.tree04.toTile();
		var trees = [tree01, tree02, tree03, tree04];
		var numOfTrees = 15;
		var spawns = getTreeSpawns(numOfTrees, worldWidth, worldHeight, bookSpawn);
		for (i in 0...numOfTrees) {
			Math.shuffle(trees);
			var spawn = spawns.pop();

			if (spawn == null)
				continue;

			var bitmap = new Bitmap(trees[0], layer);
			layer.add(bitmap, 1);
			bitmap.colorKey = 0xff00ff;
			bitmap.setScale(Math.random(.25) + .25);
			var size = bitmap.getSize();
			var collidable = new Collidable(CollisionShape.BOUNDS, 0, size.width / 2, size.height / 2);
			collidable.offsetY = size.height / 2;
			collidable.offsetX = size.width / 4;
			collidable.ignore.push(Tree.type);
			world.newEntity('tree $i')
				.add(new Tree())
				.add(new Shake())
				.add(new Transform(spawn.x, spawn.y, size.width, size.height))
				.add(collidable)
				.add(new Renderable(bitmap));
		}

		var playerTile = Res.player.toTile();
		var playerBitmap = new Bitmap(playerTile, layer);
		layer.add(playerBitmap, 1);
		playerBitmap.colorKey = 0xFF00FF;
		playerBitmap.setScale(.175);
		var playerSize = playerBitmap.getSize();
		var player = world.newEntity("player")
			.add(new Player())
			.add(new Collidable(CollisionShape.BOUNDS, 0, playerSize.width, playerSize.height))
			.add(new Renderable(playerBitmap))
			.add(new Transform(worldWidth / 2, worldHeight / 2, playerSize.width, playerSize.height))
			.add(new Velocity());

		var camera = world.newEntity("camera")
			.add(new Camera(player, Bounds.fromValues(0, 0, worldWidth, worldHeight), s2d.width / 2, s2d.height / 2))
			.add(new Transform())
			.add(new Velocity());

		world.addSystem(new PlayerController());
		world.addSystem(new BookStandController(handleBookClick));
		world.addSystem(new Collision());
		world.addSystem(new Bouncer());
		world.addSystem(new Shaker());
		world.addSystem(new TreeController(spawnWord));
		world.addSystem(new WordController());
		world.addSystem(new DialogueController());
		world.addSystem(new Renderer(camera));
		world.addSystem(new UiRenderer());
		world.addSystem(new CollisionDebug(camera, this));

		console = new Console(DefaultFont.get(), this);
		console.addCommand("debug", "", [{name: "name", t: AString}], function(name:String) {
			if (name == null) {
				world.debugLog(console);
				return;
			}

			world.debugEntity(console, name);
		});

		world.addSystem(new CameraController(s2d, console));

		makeDialogue(world, ["I don't remember why I'm here...", "I should go check that book"], s2d, this);
	}

	override function update(dt:Float) {
		#if debug
		if (console.isActive())
			return;

		if (Key.isPressed(Key.PGDOWN)) {
			Game.memories.getCurrentMemory().advanceLine();
			wordsThatNeedPickedUp = 0;
		}
		if (Key.isPressed(Key.NUMBER_1)) {
			var line = Game.memories.getCurrentMemory().getCurrentLine();
			console.log(line);
		}
		if (Key.isPressed(Key.R))
			Game.game.setGameScene(new Book(s2d));
		#end

		world.update(dt);
		layer.ysort(1);
	}

	function getTreeSpawns(n:Int, worldWidth:Float, worldHeight:Float, bookSpawn:Point):Array<Point> {
		var spawns = [];
		var failSafe = 5;
		var currentTry = 0;
		for (i in 0...n) {
			var spawn = new Point(Math.random(worldWidth), Math.random(worldHeight));
			while (currentTry < failSafe && (spawn.distance(bookSpawn) < 300 || isInDistanceOf(spawn, spawns, 750))) {
				spawn = new Point(Math.random(worldWidth), Math.random(worldWidth));
				currentTry++;
			}

			if (currentTry < failSafe) {
				spawns.push(spawn);
			}

			currentTry = 0;
		}

		return spawns;
	}

	function isInDistanceOf(a:Point, b:Array<Point>, d:Float) {
		var overlaps = false;
		for (point in b) {
			overlaps = a.distance(point) < d;

			if (overlaps)
				return true;
		}

		return false;
	}

	function spawnWord(x:Float, y:Float) {
		var word = Game.memories.getCurrentMemory().getWord();

		if (word == null) {
			makeDialogue(world, ["I don't think I'm gonna get anymore words from this..."], s2d, this);
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

	function makeDialogue(world:World, text:Array<String>, s2d:Scene, parent:Object) {
		var bg = new h2d.ScaleGrid(hxd.Res.tempui.toTile(), 5, 5, parent);
		bg.width = s2d.width;
		bg.height = s2d.height / 4;
		bg.colorKey = 0xFF00FF;
		bg.color.setColor(0x000000);
		bg.color.a = 0.75;
		var bgSize = bg.getSize();
		var tf = new h2d.Text(DefaultFont.get(), parent);
		tf.setScale(1.5);
		tf.maxWidth = 425;
		tf.y = s2d.height - bgSize.height / 2 - (tf.textHeight * tf.scaleY);
		tf.x = 50;
		tf.dropShadow = {
			dx: 0,
			dy: 1,
			color: 0,
			alpha: 0.3
		};
		var bg = world.newEntity("dialogue background").add(new Transform(0, s2d.height - s2d.height / 4, s2d.width, s2d.height / 4)).add(new Ui(bg));
		world.newEntity("dialogue")
			.add(new Ui(tf)) // .add(new Renderable(new Bitmap(Tile.fromColor(0xff0000, Std.int(tf.maxWidth), Std.int(tf.textHeight), .5), parent)))
			.add(new DialogueBox(text, 0xffffff, bg))
			.add(new Transform(tf.x, tf.y, tf.maxWidth, tf.textHeight));
		dialogueShowing = true;
	}

	var firstClick = true;
	var readyToexit = false;
	var wordsThatNeedPickedUp = 0;

	function handleBookClick() {
		var currentMemeory = Game.memories.getCurrentMemory();
		if (firstClick) {
			var currentLine = currentMemeory.getCurrentLineWithBlanks();
			var lines = ['"${currentLine}"'];

			while (!currentMemeory.lineNeedsWords()) {
				currentMemeory.advanceLine();
				lines.push('"${currentMemeory.getCurrentLineWithBlanks()}"');
				wordsThatNeedPickedUp += currentMemeory.wordsToFind;
			}

			lines.push("Hun I think I remember this happening...");
			lines.push("I should go [press space] on some trees...");
			lines.push("And see what I can shake out!");

			firstClick = false;
			makeDialogue(world, lines, s2d, this);
			return;
		}

		if (Game.memories.pickedUpWords.length < wordsThatNeedPickedUp) {
			makeDialogue(world, ["I still have words to pick up"], s2d, this);
			return;
		}

		if (currentMemeory.wordsToFind > 0) {
			var currentLine = currentMemeory.getCurrentLineWithBlanks();
			var wordOrWords = currentMemeory.wordsToFind == 1 ? "word" : "words";
			var lines = [
				'"${currentLine}"',
				'I think I can still find ${currentMemeory.wordsToFind} $wordOrWords'
			];
			makeDialogue(world, lines, s2d, this);
			return;
		}

		if (currentMemeory.wordsToFind <= 0 && !readyToexit) {
			var advanced = currentMemeory.advanceLine();
			if (advanced) {
				wordsThatNeedPickedUp += currentMemeory.wordsToFind;
				var memoryLines = [
					"What was next..?",
					"I think I'm starting to remember",
					"How did it go?",
					"Hmmm",
					"Why can't I remember?",
					"Ah, yes",
					"Next line then..."
				];
				var currentLine = currentMemeory.getCurrentLineWithBlanks();
				Math.shuffle(memoryLines);
				var lines = [memoryLines[0], '"${currentLine}"', "Let's go shake some more trees"];
				makeDialogue(world, lines, s2d, this);
			} else {
				var lines = ["Okay!", "I think I rember now", "[press space] on the book stand to remember"];
				readyToexit = true;
				makeDialogue(world, lines, s2d, this);
			}
			return;
		}

		if (readyToexit) {
			Game.game.setGameScene(new Book(Game.game.s2d));
		}
	}
}
