package princess.buccaneer.nosferatu.entities;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.Sfx;
import com.haxepunk.utils.Input;
import nme.geom.Rectangle;
import nme.geom.Point;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Text;

import princess.buccaneer.nosferatu.lighting.Light;
import princess.buccaneer.nosferatu.lighting.Lighting;
import princess.buccaneer.nosferatu.worlds.GameWorld;

/**
 * Nosferatu, our fearless player.
 * @author Princess Buccaneer */
class PlayerEntity extends WalkingEntity {
		
	static var attackTime: Float = 0.125; // seconds
	static var attackRechargeTime: Float = 1; // seconds
	var painSound: Sfx;
	
	var currentAttack: Float = 0;
	var attackRecharge: Float = 0;
	
	public var health: Int = 100;
	

	public function new() {
		super(480, 60);
		painSound = new Sfx("sfx/pain.wav");
		distancePerFootstep = 40;
		graphic = new Image("gfx/tilemap.png", new Rectangle(68, 0, 24, 28));
		
		setHitbox(24, 28, 0, 0);
	}
	
	override public function added() {
		super.added();
		addLight(new Light(new Image("gfx/ambientview.png"), 128));
	}
	
	override public function update() {
		if (attackRecharge > 0) {
			attackRecharge -= HXP.elapsed;
		}
		if (currentAttack > 0) {
			currentAttack -= HXP.elapsed;
			super.update();
			
			var array = new Array<Entity>();
			GameWorld.world.getAll(array);
			var enemies = new Array<EnemyEntity>();
			for (entity in array) {
				if (Std.is(entity, EnemyEntity)) enemies.push(cast(entity, EnemyEntity));
			}
			var closeEnemies = new Array<EnemyEntity>();
			for (enemy in enemies) {
				var d = Point.distance(new Point(x, y), new Point(enemy.x, enemy.y));
				if (d < width)
					closeEnemies.push(enemy);
			}
			for (enemy in closeEnemies) {
				new Sfx("sfx/hit.wav").play();
				HXP.world.remove(enemy);
			}
			return;
		}
		
		if (Lighting.canvas != null) {
			var rawLight: Int = Lighting.canvas.getPixel(Std.int(x), Std.int(y));
			var brightness: Int = (rawLight & 0xFF) + (rawLight >>> 8) & 0xFF + (rawLight >>> 16) & 0xFF;
			if (brightness > 37) {
				health -= Std.int(brightness * HXP.elapsed);
				if (!painSound.playing) painSound.loop();
			} else {
				painSound.stop();
			}
		}
		
		if (health <= 0) {
			LevelManager.failed();
			painSound.stop();
			world.remove(this);
		}
		
		if (Input.check("Attack") && attackRecharge <= 0) {
			currentAttack = attackTime;
			attackRecharge = attackRechargeTime;
			new Sfx("sfx/jump.wav").play();
			var p = new Point(vx, vy);
			p.normalize(maxSpeed);
			maxAccel = 10000;
			move(p.x, p.y);
			super.update();
			maxAccel = 60;
			return;
		}

		var v = new Point();
		var gridSize = 32;
		var targetSpeed = Input.check("Slow") ? maxSpeed / 6 : maxSpeed / 2;
		
		if (Input.check("Left")) {
			v.x = -targetSpeed;
		} else if (Input.check("Right")) {
			v.x = targetSpeed;
		}
		
		if (Input.check("Up")) {
			v.y = -targetSpeed;
		} else if (Input.check("Down")) {
			v.y = targetSpeed;
		}
		
		move(v.x, v.y);
		super.update();
	}
	
	override public function render() {
		super.render();
	}
	
}