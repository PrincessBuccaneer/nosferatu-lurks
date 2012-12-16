package princess.buccaneer.nosferatu.worlds;

import com.haxepunk.Sfx;
import com.haxepunk.World;
import princess.buccaneer.nosferatu.ui.TextDisplay;
import com.haxepunk.graphics.Image;

/**
 * ...
 * @author Princess Buccaneer
 */

class GameCompleteWorld extends World {
	public override function begin() {
		super.begin();
		new Sfx("music/gamecomplete.mp3").play();
		addGraphic(new Image("gfx/yourewinner.png"));
		add(new TextDisplay("YOU'RE WINNER!"));
	}
}