package princess.buccaneer.nosferatu.ai;

import nme.geom.Point;
import src.princess.buccaneer.nosferatu.ai.Behavior;

/**
 * ...
 * @author Princess Buccaneer
 */

class FollowPolylineBehavior extends Behavior {
	public var polyline: Array<Point>;
	public var polylineCounter: Int = 0;
	public var direction = 1;
		
	override public function behave() {
		if (polyline == null) entity.behavior = null;
		var target: Point = polyline[polylineCounter];
		var delta: flash.geom.Point = new flash.geom.Point(target.x - entity.x, target.y - entity.y);
		if (delta.length < 4.0) {
			polylineCounter += direction;
			if (polylineCounter == -1 || polylineCounter == polyline.length) {
				direction = -direction;
				polylineCounter += direction;
			}
			// maybe sleep for a bit?
			return;
		}
		delta.normalize(entity.maxSpeed);
		entity.move(delta.x, delta.y);
	}
	
}