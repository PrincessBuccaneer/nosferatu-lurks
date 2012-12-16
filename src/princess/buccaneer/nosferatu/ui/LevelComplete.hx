package princess.buccaneer.nosferatu.ui;

import com.haxepunk.World;


/**
 * @author Princess Buccaneer */
class LevelComplete extends LevelTransition {
	
	public function new(nextWorld: World) {
		super(nextWorld, "Level complete! Click to continue.");
	}
}