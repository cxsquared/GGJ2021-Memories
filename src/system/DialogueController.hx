package system;

import hxd.Math;
import hxd.Key;
import h2d.Text;
import component.Renderable;
import component.DialogueBox;

class DialogueController implements IPerEntitySystem {
	public var forComponents:Array<String> = [DialogueBox.type, Renderable.type];

	public function new() {}

	public function update(entity:Entity, dt:Float) {
		var dialogueBox:DialogueBox = cast entity.get(DialogueBox.type);
		var r:Renderable = cast entity.get(Renderable.type);
		var text:Text = cast r.drawable;

		text.color.setColor(dialogueBox.textColor);

		if (Key.isPressed(Key.SPACE)) {
			if (text.text == dialogueBox.visibleText) {
				entity.remove();
				return;
			}

			text.text = dialogueBox.text;
			return;
		}

		var textSoFar = dialogueBox.text.length - dialogueBox.visibleText.length;
		var rate = MathUtils.normalizeToOne(textSoFar, 0, dialogueBox.text.length);
		rate += dt * rate;
		var textLenght = Math.min(dialogueBox.text.length, Math.floor(rate * dialogueBox.text.length));
		dialogueBox.visibleText = dialogueBox.text.substring(0, Math.floor(textLenght));
		text.text = dialogueBox.visibleText;
	}
}
