package princess.buccaneer.nosferatu.lighting;
import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.World;


/**
 * A world with a lighting system.
 * @author Princess Buccaneer */
class LitWorld extends World {
	
	public var lighting:Lighting;
	
	public function new() {
		lighting = new Lighting();
		super();
	}

	override public function begin() {
		super.begin();
		HXP.screen.color = 0x000000;
		add(lighting);
		add(new Shadow());
		super.begin();
	}
	
	override public function add<E:Entity>(e:E):E {
		if (Std.is(e, LightEffect)) lighting.add(cast(e, LightEffect));
		return super.add(e);
	}
	
}