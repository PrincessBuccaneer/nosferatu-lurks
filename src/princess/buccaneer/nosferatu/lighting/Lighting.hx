package princess.buccaneer.nosferatu.lighting;
import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

import nme.display.BlendMode;
import nme.display.BitmapData;

/** @author Princess Buccaneer */
class Lighting extends Entity {
	
	public static var canvas:BitmapData;
	public static var blendMode:nme.display.BlendMode;

	public function new() {
		super();
		layer = 7; // We want all the lights to render to the canvas before we render the canvas to the screen
		canvas = new BitmapData(HXP.width, HXP.height, false, Shadow.color);
		blendMode = BlendMode.SCREEN;
	}
	
	public function add(light:LightEffect) {
		light.renderTarget = canvas;
	}
	
	override public function render() {
		super.render();
		HXP.buffer.draw(canvas, null, null, BlendMode.MULTIPLY);
	}
	
	override public function update() {
		super.update();
		// test the different blend modes that make sense
		if (Input.pressed(Key.L)) {
			if (blendMode == BlendMode.ADD) blendMode = BlendMode.SCREEN;
			else (blendMode = BlendMode.ADD);
		}
	}	
}