package memories;

class MemoryManager {
	var currentMemeory = 0;
	var usedMemories:Array<Int> = new Array<Int>();
	var memories:Array<Memory> = new Array<Memory>();

	public function new(memories:Array<Memory>) {
		this.memories = memories;
	}

	public function getCurrentMemory():Memory {
		return memories[currentMemeory];
	}

	public function finishCurrentMemory() {
		usedMemories.push(currentMemeory);
	}

	public function setRandomMemory():Memory {
		if (memories.length == usedMemories.length) {
			throw "No more memories available";
		}

		var newMemoryIndex = Math.floor(Math.random() * memories.length);
		while (usedMemories.contains(newMemoryIndex)) {
			newMemoryIndex = Math.floor(Math.random() * memories.length);
		}

		currentMemeory = newMemoryIndex;
		return getCurrentMemory();
	}
}
