package princess.buccaneer.nosferatu.ai;

import nme.geom.Point;
import src.princess.buccaneer.nosferatu.ai.Behavior;

/**
 * ...
 * @author Princess Buccaneer
 */

class FollowPolygonBehavior extends Behavior {
	public var polygon: Array<Point>;
	public var polygonCounter: Int = 0;
		
	override public function behave() {
		if (polygon == null) entity.behavior = null;
		var target: Point = polygon[polygonCounter];
		var delta: flash.geom.Point = new flash.geom.Point(target.x - entity.x, target.y - entity.y);
		if (delta.length < 4.0) {
			polygonCounter = (polygonCounter + 1) % polygon.length;
			// maybe sleep for a bit?
			return;
		}
		
		delta.normalize(entity.maxSpeed);
		entity.move(delta.x, delta.y);
	}
}