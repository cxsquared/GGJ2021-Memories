package event;

class EventBus {
	var listeners = new Map<String, Array<Dynamic>>();

	public function new() {}

	public function register<T:IEvent>(event:Class<T>) {
		var type = Type.getClassName(event);
		if (listeners.exists(type))
			return;

		listeners.set(type, new Array<(T) -> Void>());
	}

	public function subscribe<T:IEvent>(event:Class<T>, callback:(T) -> Void) {
		var type = Type.getClassName(event);
		if (!listeners.exists(type))
			listeners.set(type, new Array<T>());

		listeners.get(type).push(callback);
	}

	public function publishEvent<T:IEvent>(event:T) {
		var type = Type.getClassName(Type.getClass(event));
		if (!listeners.exists(type))
			throw "Register the event before publishing it";

		for (func in listeners.get(type))
			func(event);
	}
}
