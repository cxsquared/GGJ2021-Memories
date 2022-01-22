package component;

import h2d.Console;

class DialogueBox implements IComponent {
	public static final type = "DialogueBox";

	public var text:String;
	public var textColor:Int;
	public var visibleText:String;
	public var speed:Float = 5;
	public var background:Entity;

	public function new(text:String, textColor:Int, background:Entity) {
		this.text = text;
		this.textColor = textColor;
	}

	public function getType():String {
		return type;
	}

	public function log(console:Console, ?color:Int) {}

	public function remove() {
		background.remove();
	}
}
