import component.IComponent;

class Entity {
	static var lastId = 0;

	public var id(default, null):Int;
	public var name(default, null):String;

	var world:World;

	public function new(world:World, ?name:String):Void {
		this.id = Entity.lastId++;
		this.world = world;
		if (name != null || name == "") {
			this.name = name;
		} else {
			this.name = Std.string(id);
		}
	}

	public function add(component:IComponent):Entity {
		world.addComponent(id, component);

		return this;
	}

	public function get(type:String):Null<IComponent> {
		return world.getComponent(this, type);
	}

	public function has(type:String):Bool {
		return world.hasComponent(this, type);
	}

	public function remove() {
		world.removeEntity(this);
	}
}
