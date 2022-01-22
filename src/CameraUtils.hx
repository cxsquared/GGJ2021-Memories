import h2d.col.Point;
import component.Camera;
import component.Transform;

class CameraUtils {
	public static function worldToScreen(t:Transform, c:Camera, ct:Transform):Point {
		var position = new Point(t.x, t.y);
		return position.sub(new Point(ct.x - c.offsetX, ct.y - c.offsetY));
	}
}
