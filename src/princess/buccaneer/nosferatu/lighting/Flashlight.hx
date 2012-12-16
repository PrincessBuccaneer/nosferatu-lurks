package princess.buccaneer.nosferatu.lighting;

import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import nme.display.BitmapData;
import nme.display.Shape;
import nme.geom.Point;
import nme.geom.Rectangle;

/** @author Princess Buccaneer */
class Flashlight extends Light {

	public function new() {
		super(new Image("gfx/light.png"), 128);
	}
	
	override public function renderToTemporary() {
		super.renderToTemporary();
		var p = new Point();
		p.x = xdirection;
		p.y = ydirection;
		p.normalize(temporaryRenderTarget.width);
		var shape:Shape = new Shape();
		shape.graphics.beginFill(0x000000);
		shape.graphics.moveTo(originX, originY);
		shape.graphics.lineTo(originX + (2 * p.x + p.y) / 3, originY + (2 * p.y - p.x) / 3);
		shape.graphics.lineTo(originX + p.y, originY - p.x);
		shape.graphics.lineTo(originX - p.x, originY - p.y);
		shape.graphics.lineTo(originX - p.y, originY + p.x);
		shape.graphics.lineTo(originX + (2 * p.x - p.y) / 3, originY + (p.x + 2 * p.y) / 3);
		shape.graphics.lineTo(originX, originY);
		temporaryRenderTarget.draw(shape);
	}
	
}