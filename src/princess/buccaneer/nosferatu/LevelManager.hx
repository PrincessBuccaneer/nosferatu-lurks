package princess.buccaneer.nosferatu;
import com.haxepunk.HXP;
import com.haxepunk.Sfx;
import com.haxepunk.World;
import princess.buccaneer.nosferatu.ui.LevelComplete;
import princess.buccaneer.nosferatu.ui.LevelFailed;
import princess.buccaneer.nosferatu.worlds.GameCompleteWorld;

import princess.buccaneer.nosferatu.worlds.GameWorld;

/**
 * ...
 * @author Princess Buccaneer
 */

class LevelManager {
	
	public static var levelNames: Array<String> = [
		"maps/tutorial01.tmx",
		"maps/tutorial02.tmx",
		"maps/level01.tmx",
		"maps/level02.tmx",
		"maps/level03.tmx",
		"maps/level04.tmx"
	];
	static var levelIndex: Int = 0;
	
	public static var startWorld(getStartWorld, never): GameWorld;
	
	public static function getStartWorld() {
		return new GameWorld(levelNames[0]);
	}
		
	public static function complete() {
		levelIndex++;
		new Sfx("music/levelcomplete.mp3").play();
		var nextWorld = (levelIndex < levelNames.length) ? new GameWorld(levelNames[levelIndex]) : new GameCompleteWorld();
		HXP.world.add(new LevelComplete(nextWorld));
	}
	
	public static function failed() {
		new Sfx("music/levelfailed.mp3").play();
		HXP.world.add(new LevelFailed(new GameWorld(levelNames[levelIndex])));
	}
	
	public static function restart() {
		HXP.world = new GameWorld(levelNames[levelIndex]);
	}
	
}