package princess.buccaneer.nosferatu.ai;
import princess.buccaneer.nosferatu.entities.WalkingEntity;
import src.princess.buccaneer.nosferatu.ai.Behavior;

/**
 * ...
 * @author Princess Buccaneer
 */

class RandomWalkBehavior extends Behavior {
		
	override public function behave() {
		if (entity == null) return;
		entity.move((2 * Math.random() - 1) * entity.maxSpeed, (2 * Math.random() - 1) * entity.maxSpeed);
	}
	
}