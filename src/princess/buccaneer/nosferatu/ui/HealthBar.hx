package princess.buccaneer.nosferatu.ui;
import com.haxepunk.Entity;
import com.haxepunk.HXP;
import nme.display.Shape;

import princess.buccaneer.nosferatu.entities.PlayerEntity;
import princess.buccaneer.nosferatu.GameWorld;

/**
 * ...
 * @author Princess Buccaneer
 */
class HealthBar extends Entity {
	
	public function new() {
		super();
		x = HXP.screen.width - 24;
		y = 0;
		width = 24;
		height = HXP.screen.height;
		layer = 6;
	}

	override public function render() {
		super.render();
		var player: PlayerEntity = GameWorld.world.player;
		var health = player.health;
		var s:Shape = new Shape();
		s.graphics.beginFill(0xCC0000);
		s.graphics.drawRect(x, y, width, height * (health / 100));
		s.graphics.endFill();
		HXP.buffer.draw(s);
	}
	
}