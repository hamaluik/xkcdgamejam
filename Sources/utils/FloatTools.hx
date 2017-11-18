package utils;

class FloatTools {
	public inline static function clamp(x:Float, min:Float, max:Float):Float {
		return Math.min(max, Math.max(min, x));
	}

    public inline static function lerp(t:Float, a:Float, b:Float):Float {
        return a + t * (b - a);
    }
}
