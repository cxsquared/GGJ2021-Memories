package system;

import h2d.Object;
import h2d.Bitmap;
import h2d.Drawable;
import component.Glow;
import component.Renderable;
import component.Word;

class Glower implements IPerEntitySystem {
	public var forComponents:Array<String> = [Glow.type, Renderable.type];

	public function new() {}

	public function update(entity:Entity, dt:Float) {
		var g:Glow = cast entity.get(Glow.type);
		var r:Renderable = cast entity.get(Renderable.type);

		if (!Std.isOfType(r.drawable, Object))
			return;

		var o:Object = cast r.drawable;

		if (g.glowing && o.filter == null) {
			o.filter = new h2d.filter.Glow(g.color);
			return;
		}

		if (!g.glowing && o.filter != null) {
			o.filter = null;
		}
	}
}
