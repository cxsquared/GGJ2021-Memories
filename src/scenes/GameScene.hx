package scenes;

import h2d.Scene;

class GameScene extends h2d.Object {
	public function new(scene:Scene) {
		super(scene);
	}

	public function init():Void {
		throw "Must override init()";
	}

	public function update(dt:Float):Void {
		throw "Must override update()";
	}
}
