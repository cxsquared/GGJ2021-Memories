package system;

import h2d.Object;
import h2d.Text;
import component.Score;

class ScoreDisplay implements IPerEntitySystem {
	public var forComponents:Array<String> = [Score.type];

	var player1:Text;
	var player2:Text;

	public function new(parent:Object) {
		var s2d = parent.getScene();

		player1 = new h2d.Text(hxd.res.DefaultFont.get(), parent);
		player1.text = "0";
		player1.setPosition(s2d.width / 2 - player1.calcTextWidth("000") * 2, 10);

		player2 = new h2d.Text(hxd.res.DefaultFont.get(), parent);
		player2.text = "0";
		player2.setPosition(s2d.width / 2 + player1.calcTextWidth("000") * 2, 10);
	}

	public function update(entity:Entity, dt:Float) {
		var score:Score = cast entity.get(Score.type);

		player1.text = Std.string(score.player1);
		player2.text = Std.string(score.player2);
	}
}
