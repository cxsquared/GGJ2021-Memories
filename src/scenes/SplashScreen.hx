package scenes;

import hxd.Key;
import h2d.Layers;
import component.Button;
import system.ButtonController;
import system.UiRenderer;
import component.Ui;
import h2d.col.Point;
import h2d.Console;
import hxd.res.DefaultFont;
import h2d.Text;
import hxd.Math;
import component.Word;
import component.Bounce;
import component.Drag;
import system.Bouncer;
import system.WordController;
import system.ButtonController;
import system.DragController;
import component.Transform;
import h2d.Scene;
import hxd.Res;
import component.Renderable;
import scenes.Exploration;
import h2d.Bitmap;

class SplashScreen extends GameScene {
	var console:Console;
	var world = new World();
	var time_passed = 0.0;
	var time = 5;
	var scene:Scene;

	public function new(scene:Scene) {
		this.scene = scene;
		super(scene);
	}

	override function init() {
		var splash = new Bitmap(hxd.Res.unknown.toTile(), this);
		splash.width = scene.width;
		splash.height = scene.height;
	}

	override function update(dt:Float) {
		world.update(dt);
		time_passed += dt;
		if (time_passed > time || Key.isPressed(Key.SPACE)) {
			Game.game.setGameScene(new Exploration(scene));
		}
	}
}
