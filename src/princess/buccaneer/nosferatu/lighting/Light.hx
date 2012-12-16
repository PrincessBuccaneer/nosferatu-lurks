package princess.buccaneer.nosferatu.lighting;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import nme.display.BitmapData;
import nme.display.Shape;
import nme.geom.Matrix;
import nme.geom.Point;
import flash.display.BlendMode;
import com.haxepunk.HXP;
import nme.geom.Rectangle;

/** 
 * A LightEffect with a radius and a graphic.
 * @author Princess Buccaneer */
class Light extends LightEffect {
	
	var radius:Float;
	var image:Image;
	var temporaryRenderTarget:BitmapData;
	
	public function new(graphic:Image, radius:Float = 128) {
		super();
		
		this.radius = radius;
		this.graphic = graphic;
		image = graphic;
		var r:Int = Std.int(radius);
		setHitbox(r * 2, r * 2, r, r);
		var diameter: Int = Std.int(radius * 2);
		temporaryRenderTarget = new BitmapData(diameter, diameter, false, 0x000000);
	}
	
	private function renderToTemporary() {
		var p = new Point();
		temporaryRenderTarget.fillRect(new Rectangle(0, 0, radius * 2, radius * 2), 0x000000);
		
		var bigRT = new BitmapData(image.width, image.height, 0x000000);
		graphic.render(bigRT, p, p);
		var m: flash.geom.Matrix = new flash.geom.Matrix();
		m.scale(temporaryRenderTarget.width / bigRT.width, temporaryRenderTarget.height / bigRT.height);
		temporaryRenderTarget.draw(bigRT, m);
	}
	
	override public function render() {
		renderToTemporary();
		var transform = new Matrix();
		transform.translate(x - radius - HXP.camera.x, y - radius - HXP.camera.y);
		renderTarget.draw(temporaryRenderTarget, transform, null, Lighting.blendMode);
	}
	
	public function getShadowedEntities(): Array<Entity> {
		var into:Array<Entity> = [null];
		HXP.world.getType("enemy", into);
		if (into[0] != null) trace(into[0].type);
		return into;
		
	}

}