package princess.buccaneer.nosferatu.entities;
import com.haxepunk.Sfx;
import com.haxepunk.utils.Draw;
import nme.geom.Point;
import com.haxepunk.HXP;

import princess.buccaneer.nosferatu.lighting.LitEntity;

/**
 * An entity which walks around going tappatappatappa on the ground
 * @author Princess Buccaneer */
class WalkingEntity extends LitEntity {
	
	public var maxSpeed: Float; // pixels per second
	public var maxAccel: Float; // pixels per second per second
	public var maxTurn: Float = 0.3; // maximum turning speed
	public var distancePerFootstep: Int = -1; // pixels
	private var distanceSinceLastFootstep: Int = 0;
	
	public var vx:Float = 0;
	public var vy: Float = 0;
	
	public function new(maxSpeed: Float = 240, maxAccel: Float = 800) {
		super();
		this.maxSpeed = maxSpeed;
		this.maxAccel = maxAccel;
		
	}
	
	override public function update() {
		var gridSize = 32; // psh yeah i'll just hard code this what could go wrong
		
		
		var oldX = x;
		var oldY = y;
		x += vx * HXP.elapsed;
			
		if (collide("solid", x, y) != null) {
			if (HXP.sign(vx) > 0) x = Math.floor((x + width) / gridSize) * gridSize - width;
			else x = Math.floor(x / gridSize) * gridSize + gridSize;
		}
		
		y += vy * HXP.elapsed;
		
		if (collide("solid", x, y) != null) {
			if (HXP.sign(vy) > 0) y = Math.floor((y + height) / gridSize) * gridSize - height;
			else y = Math.floor(y / gridSize) * gridSize + gridSize;
		}
		oldX -= x;
		oldY -= y;
		if (distancePerFootstep > 0) {
			distanceSinceLastFootstep += Math.round(Math.sqrt(oldX * oldX + oldY * oldY));
			if (distanceSinceLastFootstep > distancePerFootstep) {
				distanceSinceLastFootstep = 0;
				footstep();
			}
		}
		
		
		// todo properly
		var deltaDirection = new Point(vx - xdirection, vy - ydirection);
		if (deltaDirection.length > maxTurn) deltaDirection.normalize(maxTurn);
		xdirection += deltaDirection.x;
		ydirection += deltaDirection.y;
		
		super.update();
	}
	
	/// this should only be called once per tick, and before update()
	public function move(targetVX:Float, targetVY: Float) {
		var V = new Point(targetVX - vx, targetVY - vy);
		if (V.length > maxAccel) V.normalize(maxAccel); // clamp to the maximum acceleration...
		V.x += vx;
		V.y += vy;
		if (V.length > maxSpeed) V.normalize(maxSpeed); // ... and maximum speed
		vx = V.x;
		vy = V.y;
	}
	
	public function footstep() {
		var sound: Sfx = new Sfx("sfx/footstep.wav");
		var volume = Math.sqrt(vx * vx + vy * vy)/ maxSpeed;
		SoundManager.play(sound, new Point(x, y), volume);
	}
	
	public override function render() {
		super.render();
	#if debug
		Draw.hitbox(this, true, 0xFF00FF);
	#end
	}
	
}