package memories;

class MemoryManager {
	var currentMemeory = 0;
	var usedMemories = new Array<Int>();

	public var memories = new Array<Memory>();

	public var pickedUpWords = new Array<Word>();

	public function new(memories:Array<Memory>) {
		this.memories = memories;
	}

	public function getCurrentMemory():Memory {
		return memories[currentMemeory];
	}

	public function finishCurrentMemory() {
		usedMemories.push(currentMemeory);
	}

	public function setMemory(i:Int) {
		currentMemeory = i;
	}

	public function setRandomMemory():Memory {
		if (memories.length == usedMemories.length) {
			usedMemories = new Array<Int>();
		}

		var newMemoryIndex = Math.floor(Math.random() * memories.length);
		while (usedMemories.contains(newMemoryIndex)) {
			newMemoryIndex = Math.floor(Math.random() * memories.length);
		}

		currentMemeory = newMemoryIndex;
		return getCurrentMemory();
	}
}
