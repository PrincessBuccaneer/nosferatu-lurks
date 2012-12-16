package princess.buccaneer.nosferatu;

import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.World;

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
					HXP.world = new GameWorld("maps/level01.tmx");
	}
	
}