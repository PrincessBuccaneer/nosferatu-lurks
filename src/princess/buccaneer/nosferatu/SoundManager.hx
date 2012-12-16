package princess.buccaneer.nosferatu;
import com.haxepunk.Entity;
import com.haxepunk.Sfx;
import haxe.PosInfos;
import nme.geom.Point;

import com.haxepunk.utils.Draw;

/**
 * ...
 * @author Princess Buccaneer
 */

class SoundManager extends Entity {
	
	private static var _instance;
	public function new() {
		_instance = this;
		super();
		layer = 100;
	}
	
	public static var lastsfx:Sfx;
	public static var lastpos:Point;
	
	public static function play(sfx: Sfx, pos: Point, vol: Float) {
		sfx.volume = vol;
		sfx.volume = 0.001;
		sfx.play();
		lastsfx = sfx;
		lastpos = pos;
	}
	
	override public function render() {

		if (lastsfx == null) return;
	#if debug
		var x:Int = Std.int(lastpos.x);
		var y:Int = Std.int(lastpos.y);
		var c:Int = 0x00FF00;
		Draw.line(x - 2, y - 2, x + 2, y + 2, c);
		Draw.line(x - 2, y + 2, x + 2, y - 2, c);
	#end
	}
}