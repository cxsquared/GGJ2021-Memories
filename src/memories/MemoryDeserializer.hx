package memories;

class MemoryDeserializer {
	public static function deserializeMemoryJson(json:Dynamic):Array<Memory> {
		var memories = new Array<Memory>();
		var memoryObjects:Array<Dynamic> = json.memories;

		for (memory in memoryObjects) {
			var memory = new Memory(memory);
			memories.push(memory);
		}

		return memories;
	}
}
