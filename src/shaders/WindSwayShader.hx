package shaders;

import hxd.Math;

class WindSwayShader extends hxsl.Shader {
	static var SRC = {
		@:import h3d.shader.Base2d;
		// Wind settings.
		@param var speed:Float;
		@param var minStrength:Float;
		@param var maxStrength:Float;
		@param var strengthScale:Float;
		@param var interval:Float;
		@param var detail:Float;
		@param var distortion:Float;
		@param var heightOffset:Float;
		// With the offset value, you can if you want different moves for each asset. Just put a random value (1, 2, 3) in the editor. Don't forget to mark the material as unique if you use this
		@param var offset:Float;
		function getWind(vertex:Vec2, uv:Vec2, inTime:Float):Float {
			var diff = pow(maxStrength - minStrength, 2.0);
			var strength = clamp(minStrength + diff + sin(inTime / interval) * diff, minStrength, maxStrength) * strengthScale;
			var wind = (sin(inTime) + cos(inTime * detail)) * strength * max(0.0, (1.0 - uv.y) - heightOffset);

			return wind;
		}
		function vertex() {
			var inTime = time * speed + offset;
			absolutePosition.x += getWind(input.position, input.uv, inTime);
		}
	}

	public function new(?speed = 1.0) {
		super();
		this.speed = 1.0;
		this.minStrength = 0.05;
		this.maxStrength = 0.01;
		this.strengthScale = 100.0;
		this.interval = 3.5;
		this.detail = 1.0;
		this.distortion = 0;
		this.heightOffset = 0;
		this.offset = Math.random(100);
	}
}
