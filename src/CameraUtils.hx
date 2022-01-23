import hxd.Math;
import h2d.col.Point;
import component.Camera;
import component.Transform;

class CameraUtils {
	public static function worldToScreen(t:Transform, c:Camera, ct:Transform):Point {
		var position = new Point(t.x, t.y);

		var offsetX = Math.clamp(ct.x - c.offsetX, c.bounds.x, c.bounds.width - c.offsetX * 2);
		var offsetY = Math.clamp(ct.y - c.offsetY, c.bounds.y, c.bounds.height - c.offsetY * 2);

		return position.sub(new Point(offsetX, offsetY));
	}
}
