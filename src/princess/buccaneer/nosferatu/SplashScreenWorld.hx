package princess.buccaneer.nosferatu;

import com.haxepunk.graphics.Image;
import com.haxepunk.Sfx;
import com.haxepunk.World;
import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.Graphic;
import com.haxepunk.utils.Input;

/**
 * A world which dislpays a series of splashscreen images and then starts the Main Menu world.
 * @author Princess Buccaneer */
class SplashScreenWorld extends World {
	
	public function new() {
		super();
		var splash1 = new SplashImage(1.5, new Image("gfx/splashscreen1.png"));
		var splash2 = new SplashImage(1.5, new Image("gfx/splashscreen2.png"));
		var splash3 = new SplashImage(1.5, new Image("gfx/splashscreen3.png"));
		splash1.start(splash2);
		splash2.start(splash3);
		splash3.start(new MainMenuWorld());
		add(splash1);
		#if !debug
		new Sfx("music/titlesong.mp3").play();
		#end
	}
	
}

class SplashImage extends Entity {
	var totalTicks:Int;
	var elapsedTicks:Int = 0;
	var onComplete: Void -> Void = null;
	
	
	public function new(splashTime:Float = 2, graphic:Graphic) {
		totalTicks = cast(Main.frameRate * splashTime, Int);
		this.graphic = graphic;
		super();
	}
	
	public function start(?entity:Entity, ?world:World) {
		if (entity != null) {
			onComplete = function() {
				HXP.world.remove(this);
				HXP.world.add(entity);
			}
		} else if (world != null) {
			onComplete = function() {
				HXP.world.remove(this);
				HXP.world = world;
			}
		} else {
			onComplete = function() {
				HXP.world.remove(this);
			}
		}
		
	}
	
	override function update() {
			elapsedTicks++;
			if (elapsedTicks >= totalTicks || Input.mousePressed) onComplete();
	}
}