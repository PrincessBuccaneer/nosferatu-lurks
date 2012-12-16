package princess.buccaneer.nosferatu;

import com.haxepunk.HXP;
import com.haxepunk.Engine;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import flash.display.StageAlign;
import flash.display.StageDisplayState;
import flash.display.StageQuality;
import flash.display.StageScaleMode;
import flash.events.Event;

/** @author Princess Buccaneer */
class Main extends Engine {
	
	public static inline var screenWidth:Int = 800;
	public static inline var screenHeight:Int = 480;
	public static inline var frameRate:Int = 30;
	public static inline var clearColor:Int = 0x333333;
	public static inline var projectName:String = "Nosferatu Lurks";
	
	public function new() {
		super(screenWidth, screenHeight, frameRate, false);
	}

	override function init() {
	#if debug
		#if flash
		if (flash.system.Capabilities.isDebugger)
		#end
		{
			HXP.console.enable();
			HXP.console.toggleKey = Key.P;
		}
	#end
		org.flashdevelop.utils.FlashConnect.redirect();
		HXP.screen.color = clearColor;
	#if debug
		HXP.world = new GameWorld("maps/level01.tmx");
	#else
		HXP.world = new SplashScreenWorld();
	#end
		
		setStageProperties();
		setupInput();
	}
	
	static public function main() {
		new Main();
	}
	
	override public function setStageProperties()
	{
		HXP.stage.frameRate = HXP.assignedFrameRate;
		HXP.stage.align = StageAlign.TOP_LEFT;
		HXP.stage.quality = StageQuality.HIGH;
		HXP.stage.scaleMode = StageScaleMode.NO_SCALE;
		HXP.stage.displayState = StageDisplayState.NORMAL;

		resize();

		HXP.stage.addEventListener(Event.ACTIVATE, function (e:Event) {
			HXP.focused = true;
			focusGained();
			HXP.world.focusGained();
		});

		HXP.stage.addEventListener(Event.DEACTIVATE, function (e:Event) {
			HXP.focused = false;
			focusLost();
			HXP.world.focusLost();
		});
	}
	
	public function setupInput() {
		Input.define("Left", [Key.A, Key.LEFT, Key.J, Key.Q]);
		Input.define("Right", [Key.D, Key.RIGHT, Key.L]);
		Input.define("Up", [Key.W, Key.UP, Key.I, Key.Z]);
		Input.define("Down", [Key.S, Key.DOWN, Key.K]);
		Input.define("Slow", [Key.CONTROL, Key.SHIFT]);
		Input.define("Attack", [Key.SPACE]);
	}
	
}
