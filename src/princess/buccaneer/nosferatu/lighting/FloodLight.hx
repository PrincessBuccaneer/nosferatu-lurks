package princess.buccaneer.nosferatu.lighting;

import com.haxepunk.graphics.Image;

/**
 * A light that shines in all directions.
 * @author Princess Buccaneer */
class FloodLight extends Light {

	public function new(radius: Float) {
		super(new Image("gfx/light.png"), radius);
	}
	
}