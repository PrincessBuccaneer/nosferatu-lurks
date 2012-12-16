package princess.buccaneer.nosferatu.ui;
import com.haxepunk.World;

/**
 * @author Princess Buccaneer */
class LevelFailed extends LevelTransition {
	
	public function new(nextWorld: World) {
		super(nextWorld, "Level failed! Click to continue.");
	}
}