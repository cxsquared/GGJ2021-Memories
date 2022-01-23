package system;

import scenes.Exploration;
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

		var thisLine = dialogueBox.text[dialogueBox.currentLine];

		if (Key.isPressed(Key.SPACE)) {
			if (text.text == thisLine) {
				dialogueBox.currentLine++;
				if (dialogueBox.currentLine >= dialogueBox.text.length) {
					entity.remove();

					Exploration.dialogueShowing = false;

					return;
				}

				dialogueBox.visibleText = "";
			} else {
				dialogueBox.visibleText = thisLine;
				text.text = dialogueBox.visibleText;
			}
		}

		if (text.text == thisLine)
			return;

		var rate = MathUtils.normalizeToOne(dialogueBox.visibleText.length, 0, thisLine.length);
		rate += dialogueBox.speed;
		var textLenght = Math.min(thisLine.length, Math.floor(rate * thisLine.length));
		dialogueBox.visibleText = thisLine.substring(0, Math.floor(textLenght));
		text.text = dialogueBox.visibleText;
	}
}
