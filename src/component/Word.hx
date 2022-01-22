package component;

import h2d.Console;
import h2d.Object;
import hxd.res.DefaultFont;
import h2d.Text;

class Word implements IComponent {
	public static final type = "Word";

	public var word:String;
	public var text:Text;

	public function new(word:String, parent:Object) {
		this.word = word;
		this.text = new Text(DefaultFont.get(), parent);
		text.text = word;
	}

	public function getType():String {
		return type;
	}

	public function log(console:Console, ?color:Int) {}

	public function remove() {
		text.remove();
	}
}
