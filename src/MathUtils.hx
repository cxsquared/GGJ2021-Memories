class MathUtils {
	public static function normalizeToOne(value:Float, min:Float, max:Float):Float {
		return (value - min) / (max - min);
	}
}
