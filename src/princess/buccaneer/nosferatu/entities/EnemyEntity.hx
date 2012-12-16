package princess.buccaneer.nosferatu.entities;

import com.haxepunk.graphics.Image;
import nme.geom.Rectangle;

import princess.buccaneer.nosferatu.lighting.Flashlight;
import princess.buccaneer.nosferatu.lighting.FloodLight;

/** @author Princess Buccaneer */
class EnemyEntity extends AiEntity {

	public function new() {
		type = "enemy";
		super();
		maxSpeed = 60;
		maxAccel = 20;
		graphic = new Image("gfx/tilemap.png", new Rectangle(100, 4, 24, 24));
		setHitboxTo(graphic);
	}
	
	public override function added() {
		super.added();
		if (Math.isNaN(xdirection) || (xdirection == 0 && ydirection == 0)) {
			xdirection = 2 * Math.random() - 1;
			ydirection = 2 * Math.random() - 1;
		}
		addLight(new FloodLight(24));
		addLight(new Flashlight());
	}
	
}