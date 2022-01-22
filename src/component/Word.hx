package component;

import h2d.col.Point;
import h2d.Console;

class Word implements IComponent {
	public static final type = "Word";

	public var word:memories.Word;
	public var target:Point;
	public var start:Point;
	public var timeToTarget:Float = .5;
	public var duration:Float = 0;

	public function new(word:memories.Word, start:Point, target:Point) {
		this.word = word;
		this.target = target;
		this.start = start;
	}

	public function getType():String {
		return type;
	}

	public function log(console:Console, ?color:Int) {}

	public function remove() {}
}
