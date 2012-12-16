package princess.buccaneer.nosferatu.worlds;

import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.World;

import princess.buccaneer.nosferatu.LevelManager;

/**
 * A world which displays the main game menu.
 * @author Princess Buccaneer */
class MainMenuWorld extends World {
	
	override public function begin() {
		addGraphic(new Image("gfx/titlescreen.png"));
	}
	
	public function new() {
		super();
		HXP.screen.color = 0x333333;
	}
	
	override public function update() {
				if (Input.mousePressed || Input.check(Key.ANY))
					HXP.world = LevelManager.startWorld;
	}
	
}