import h2d.Console;
import system.IPerEntitySystem;
import system.IAllEntitySystem.IAllEntitySystems;
import system.ISystem;
import component.IComponent;

class World {
	var entities:Array<Entity>;
	var components:Map<String, Map<Int, IComponent>>;
	var systems:Array<ISystem>;

	public function new() {
		entities = new Array<Entity>();
		components = new Map<String, Map<Int, IComponent>>();
		systems = new Array<ISystem>();
	}

	public function newEntity(?name:String) {
		var entity = new Entity(this, name);
		entities.push(entity);
		return entity;
	}

	public function removeEntity(entity:Entity) {
		for (component in components.keys()) {
			if (components[component].exists(entity.id)) {
				components[component][entity.id].remove();
				components[component].remove(entity.id);
			}
		}

		entities.remove(entity);
	}

	public function addSystem(s:ISystem) {
		systems.push(s);
	}

	public function getComponent(entity:Entity, type:String):Null<IComponent> {
		if (!components.exists(type))
			return null;

		if (!components[type].exists(entity.id))
			return null;

		return components[type][entity.id];
	}

	public function hasComponent(entity:Entity, type:String):Bool {
		if (!components.exists(type))
			return false;

		return components[type].exists(entity.id);
	}

	public function addComponent(entityId:Int, component:IComponent) {
		var componentType = component.getType();
		if (components[componentType] == null) {
			components[componentType] = new Map<Int, IComponent>();
		}

		components[componentType][entityId] = component;
	}

	public function update(dt:Float) {
		for (system in systems) {
			var entitiesToProcess = entities;
			for (type in system.forComponents) {
				entitiesToProcess = getEntitiesWithComponent(entitiesToProcess, type);
			}

			if (Std.isOfType(system, IAllEntitySystems)) {
				Std.downcast(system, IAllEntitySystems).updateAll(entitiesToProcess, dt);
				continue;
			}

			var perEntitySystem = Std.downcast(system, IPerEntitySystem);

			for (entity in entitiesToProcess) {
				perEntitySystem.update(entity, dt);
			}
		}
	}

	public function debugLog(console:Console) {
		console.log("World");
		console.log("Entities:");
		for (entity in entities) {
			var color = Std.int(Math.random() * 0xFFFFFF);
			console.log('id: ${entity.id}', color);
			console.log("components: ", color);
			for (type in components.keys()) {
				if (components[type].exists(entity.id)) {
					console.log('type: $type', color);
					components[type][entity.id].log(console, color);
				}
			}
		}
	}

	public function debugEntity(console:Console, name:String) {
		for (entity in entities) {
			if (entity.name != name)
				continue;

			var color = Std.int(Math.random() * 0xFFFFFF);
			console.log('id: ${entity.id}', color);
			console.log("components: ", color);
			for (type in components.keys()) {
				if (components[type].exists(entity.id)) {
					console.log('type: $type', color);
					components[type][entity.id].log(console, color);
				}
			}
		}
	}

	function getEntitiesWithComponent(entitiesToFilter:Array<Entity>, componentType:String) {
		var entitiesWithComponent = new Array<Entity>();
		if (!components.exists(componentType))
			return entitiesWithComponent;

		for (entity in entitiesToFilter) {
			if (components[componentType][entity.id] != null) {
				entitiesWithComponent.push(entity);
			}
		}
		return entitiesWithComponent;
	}
}
