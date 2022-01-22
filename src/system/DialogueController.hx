package system;

import component.Ui;
import hxd.Math;
import hxd.Key;
import h2d.Text;
import component.DialogueBox;

class DialogueController implements IPerEntitySystem {
	public var forComponents:Array<String> = [DialogueBox.type, Ui.type];

	public function new() {}

	public function update(entity:Entity, dt:Float) {
		var dialogueBox:DialogueBox = cast entity.get(DialogueBox.type);
		var r:Ui = cast entity.get(Ui.type);
		var text:Text = cast r.drawable;

		text.color.setColor(dialogueBox.textColor);

		if (Key.isPressed(Key.SPACE)) {
			if (text.text == dialogueBox.visibleText) {
				entity.remove();
				return;
			}

			dialogueBox.visibleText = dialogueBox.text;
			text.text = dialogueBox.visibleText;
			return;
		}

		var rate = MathUtils.normalizeToOne(dialogueBox.visibleText.length, 0, dialogueBox.text.length);
		rate += dt * dialogueBox.speed;
		var textLenght = Math.min(dialogueBox.text.length, Math.floor(rate * dialogueBox.text.length));
		dialogueBox.visibleText = dialogueBox.text.substring(0, Math.floor(textLenght));
		text.text = dialogueBox.visibleText;
	}
}
