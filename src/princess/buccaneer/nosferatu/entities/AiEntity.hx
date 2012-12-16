package princess.buccaneer.nosferatu.entities;
import princess.buccaneer.nosferatu.ai.RandomWalkBehavior;
import src.princess.buccaneer.nosferatu.ai.Behavior;

/**
 * ...
 * @author Princess Buccaneer
 */

class AiEntity extends WalkingEntity {
	
	public var behavior(default, setBehavior): Behavior;
	
	function setBehavior(v: Behavior): Behavior {
		v.entity = this;
		return behavior = v;
	}
	
	override public function added() {
		super.added();
		if (behavior == null) behavior = new RandomWalkBehavior();
	}

	override public function update() {
		if (behavior == null) behavior = new RandomWalkBehavior();
		behavior.behave();
		super.update();
	}
	
}