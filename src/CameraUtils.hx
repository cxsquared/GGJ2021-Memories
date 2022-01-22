import hxd.Math;
import h2d.col.Point;
import component.Camera;
import component.Transform;

class CameraUtils {
	public static function worldToScreen(t:Transform, c:Camera, ct:Transform):Point {
		var position = new Point(t.x, t.y);

		var offsetX = Math.clamp(ct.x - c.offsetX, c.bounds.x, c.bounds.width);
		var offsetY = Math.clamp(ct.y - c.offsetY, c.bounds.y, c.bounds.height);

		return position.sub(new Point(offsetX, offsetY));
	}
}
