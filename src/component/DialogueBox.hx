package component;

import h2d.Console;

class DialogueBox implements IComponent {
	public static final type = "DialogueBox";

	public var text:Array<String>;
	public var currentLine = 0;
	public var textColor:Int;
	public var visibleText:String;
	public var speed:Float = .05;
	public var background:Entity;

	public function new(text:Array<String>, textColor:Int, background:Entity) {
		this.text = text;
		this.textColor = textColor;
		visibleText = "";
		this.background = background;
	}

	public function getType():String {
		return type;
	}

	public function log(console:Console, ?color:Int) {}

	public function remove() {
		background.remove();
	}
}
