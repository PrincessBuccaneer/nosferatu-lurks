package princess.buccaneer.nosferatu.lighting;
import com.haxepunk.HXP;

/**
 * This light effect is responsible for making the lighting buffer dark at the beginning of every frame.
 * @author Princess Buccaneer */
class Shadow extends LightEffect {
	
	public static var color = 0x000000;
	
	public function new() {
		super();
		layer = 16384; // we need to apply the shadow (ie. fill the canvas with black) before any lights can illuminate it
	}

	override public function render() {
		renderTarget.fillRect(HXP.bounds, color);
	}
	
}