package princess.buccaneer.nosferatu.ui;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Text;
import com.haxepunk.HXP;
import nme.text.TextFormatAlign;

import princess.buccaneer.nosferatu.worlds.GameWorld;

/**
 * ...
 * @author Princess Buccaneer
 */

class TextDisplay extends Entity {
	
	static var textDisplay : TextDisplay;
	
	public function new(text: String = "") {
		super();
		var t: Text = new Text(text, 0, 0, 0, 0, { size : 36, color : 0xFFFFFF, font : "font/Eccentric.ttf" });
		setHitboxTo(t);
		graphic = t;
		layer = 6;
		x = (HXP.width - width) / 2;
		y = HXP.height - 64;
	}
	
	override public function added() {
		if (textDisplay != null) world.remove(textDisplay);
		textDisplay = this;
		super.added();
	}
		
}