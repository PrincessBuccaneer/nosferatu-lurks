package princess.buccaneer.nosferatu.entities;
import com.haxepunk.Entity;
import flash.geom.Point;

/**
 * An entity which has a direction.
 * @author Princess Buccaneer */
class DirectionalEntity extends Entity {
	
	public var xdirection: Float = 0;
	public var ydirection: Float = 0;
	
	public override function update() {
		super.update();
		var p = new Point(xdirection, ydirection);
		p.normalize(1);
		xdirection = p.x;
		ydirection = p.y;
	}
	
}