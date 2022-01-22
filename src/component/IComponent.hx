package component;

import h2d.Console;

interface IComponent {
	public function getType():String;
	public function log(console:Console, ?color:Null<Int>):Void;
}
