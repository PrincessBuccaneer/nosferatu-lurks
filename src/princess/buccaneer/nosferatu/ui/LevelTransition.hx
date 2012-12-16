package princess.buccaneer.nosferatu.ui;

import com.haxepunk.World;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;

/**
 * ...
 * @author Princess Buccaneer
 */

class LevelTransition extends TextDisplay { 
	
	public var nextWorld: World;

	public function new(nextWorld: World, text: String = "") {
		this.nextWorld = nextWorld;
		super(text);
	}
	
	override public function update() {
		super.update();
		if (Input.mousePressed) {
			HXP.world = nextWorld;
		}
	}
	
}