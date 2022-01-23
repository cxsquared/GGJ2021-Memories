package memories;

import hxd.Math;
import memories.Word.WordType;

class Memory {
	var currentLine = 0;

	public var lines:Array<String> = new Array();
	var requiredWordTypes:Array<WordType> = new Array();
	var nouns:Array<Word> = new Array();
	var pluralnoun:Array<Word> = new Array();
	var pasttenseverb:Array<Word> = new Array();
	var verb:Array<Word> = new Array();
	var ingverbs:Array<Word> = new Array();
	var adjectives:Array<Word> = new Array();
	var relationships:Array<Word> = new Array();

	public function new(jsonObject:Dynamic) {
		lines = jsonObject.lines;

		var nounStrings:Array<String> = jsonObject.nouns;
		if (nounStrings != null) {
			this.nouns = parseWordType(nounStrings, WordType.NOUN);
		}

		var pluralNounString:Array<String> = jsonObject.pluralnoun;
		if (pluralNounString != null) {
			this.pluralnoun = parseWordType(pluralNounString, WordType.PLURALNOUN);
		}

		var pasttenseverbStrings:Array<String> = jsonObject.pasttenseverb;
		if (pasttenseverbStrings != null) {
			this.pasttenseverb = parseWordType(pasttenseverbStrings, WordType.PASTTENSEVERB);
		}

		var ingverbStrings:Array<String> = jsonObject.ingverbs;
		if (ingverbStrings != null) {
			this.ingverbs = parseWordType(ingverbStrings, WordType.INGVERB);
		}

		var adjectiveStrings:Array<String> = jsonObject.adjective;
		if (adjectiveStrings != null) {
			this.adjectives = parseWordType(adjectiveStrings, WordType.ADJECTIVES);
		}

		var relationshipStrings:Array<String> = jsonObject.relationships;
		if (relationshipStrings != null) {
			this.relationships = parseWordType(relationshipStrings, WordType.RELATIONSHIPS);
		}

		var verbStrings:Array<String> = jsonObject.verbs;
		if (verbStrings != null) {
			this.verb = parseWordType(verbStrings, WordType.VERB);
		}

		requiredWordTypes = getNeededWordTypes(lines[currentLine]);
	}

	public function getWord() {
		if (requiredWordTypes.length > 0) {
			var nextType = requiredWordTypes.shift();
			return getWordByType(nextType);
		}

		return getRandomWordForLine(lines[currentLine]);
	}

	function getRandomWordForLine(line:String):Word {
		var validWordTypes = getNeededWordTypes(line);

		if (validWordTypes.length == 0) {
			return null;
		}

		var randomIndex = Math.floor(Math.random(validWordTypes.length));

		var returnWord = null;
		var failSafe = 50;
		var tries = 0;
		while (returnWord == null && tries < failSafe) {
			tries++;
			var randomType = validWordTypes[randomIndex];
			returnWord = getWordByType(randomType);
			randomIndex = Math.floor(Math.random(validWordTypes.length));
		}

		return returnWord;
	}

	function getWordByType(type:WordType):Word {
		switch (type) {
			case NOUN:
				return getRandomFromArray(nouns);
			case PLURALNOUN:
				return getRandomFromArray(pluralnoun);
			case PASTTENSEVERB:
				return getRandomFromArray(pasttenseverb);
			case INGVERB:
				return getRandomFromArray(ingverbs);
			case ADJECTIVES:
				return getRandomFromArray(adjectives);
			case RELATIONSHIPS:
				return getRandomFromArray(relationships);
			case VERB:
				return getRandomFromArray(verb);
		}

		return null;
	}

	function getRandomFromArray(array:Array<Word>):Word {
		var i = Math.floor(Math.random(array.length));
		var w = array[i];
		array.remove(w);
		return w;
	}

	public function hasNextLine():Bool {
		return currentLine < lines.length;
	}

	public function advanceLine() {
		if (!hasNextLine())
			return;

		currentLine++;
		requiredWordTypes = getNeededWordTypes(lines[currentLine]);
	}

	public function getCurrentLine():String {
		if (currentLine >= lines.length)
			return "";

		return lines[currentLine];
	}

	public function validFinish(fillIns:Array<Word>):Bool {
		var wordTypesNeeded = getNeededWordTypes(lines[currentLine]);

		var i = 0;
		for (type in wordTypesNeeded) {
			if (type != fillIns[i].type)
				return false;

			i++;
		}

		return true;
	}

	public function finishCurrentLine(fillIns:Array<Word>):String {
		var wordTypesNeeded = getNeededWordTypes(lines[currentLine]);
		var currentLine = lines[currentLine];
		var i = 0;
		for (type in wordTypesNeeded) {
			currentLine = StringTools.replace(currentLine, wordTypeToString(type), fillIns[i].text);
			i++;
		}
		return currentLine;
	}

	function getNeededWordTypes(line:String):Array<WordType> {
		var types = new Array<WordType>();
		if (line == null || line == "")
			return types;

		var fillIns = line.split("${");
		if (fillIns[0] == line)
			return types;

		// 0 is stuff at the start of the sentance
		fillIns.shift();

		for (fillIn in fillIns) {
			var endFill = fillIn.indexOf('}');
			var fillType = fillIn.substring(0, endFill);

			types.push(stringToWordType(fillType));
		}

		return types;
	}

	function stringToWordType(type:String):WordType {
		switch (type) {
			case "noun":
				return WordType.NOUN;
			case "pluralnoun":
				return WordType.PLURALNOUN;
			case "pasttenseverb":
				return WordType.PASTTENSEVERB;
			case "ingverb":
				return WordType.INGVERB;
			case "adjective":
				return WordType.ADJECTIVES;
			case "relationship":
				return WordType.RELATIONSHIPS;
			case "verb":
				return WordType.VERB;
		}

		throw "Invalid word type: " + type;
	}

	function wordTypeToString(type:WordType):String {
		switch (type) {
			case NOUN:
				return "${noun}";
			case PLURALNOUN:
				return "${pluralnoun}";
			case PASTTENSEVERB:
				return "${pasttenseverb}";
			case INGVERB:
				return "${ingverb}";
			case ADJECTIVES:
				return "${adjective}";
			case RELATIONSHIPS:
				return "${relationship}";
			case VERB:
				return "${verb}";
		}

		throw "Invalid word type: " + type;
	}

	function parseWordType(texts:Array<String>, type:WordType):Array<Word> {
		var words = new Array<Word>();
		for (text in texts) {
			var word = new Word(text, type);
			words.push(word);
		}

		return words;
	}
}
