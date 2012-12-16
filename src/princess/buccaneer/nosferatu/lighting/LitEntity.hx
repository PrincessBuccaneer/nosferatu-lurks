package princess.buccaneer.nosferatu.lighting;
import com.haxepunk.Entity;
import com.haxepunk.HXP;

import princess.buccaneer.nosferatu.entities.DirectionalEntity;

/**
 * An entity with lights attached to it.
 * @author Princess Buccaneer */
class LitEntity extends DirectionalEntity {
	
	public var lights:List<LightEffect>;
	
	public function new() {
		super();
		lights = new List<LightEffect>();
	}
	
	public function addLight(light: LightEffect) {
		super.added();
		lights.add(light);
		light.layer = layer + 1;
		HXP.world.add(light);
	}
	
	override public function removed() {
		super.removed();
		HXP.world.removeList(lights);
	}
	
	override public function update() {
		super.update();
		for (light in lights) {
			light.x = x + originX + halfWidth;
			light.y = y + originY + halfHeight;
			light.xdirection = xdirection;
			light.ydirection = ydirection;
		}
	}
	
}