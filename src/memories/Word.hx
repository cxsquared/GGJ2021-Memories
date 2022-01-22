package memories;

class Word {
	public var text:String;
	public var type:WordType;

	public function new(text:String, type:WordType) {
		this.text = text;
		this.type = type;
	}
}

enum WordType {
	NOUN;
	VERB;
	PLURALNOUN;
	PASTTENSEVERB;
	INGVERB;
	ADJECTIVES;
	RELATIONSHIPS;
}
