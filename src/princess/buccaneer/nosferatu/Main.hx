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

import princess.buccaneer.nosferatu.worlds.GameWorld;
import princess.buccaneer.nosferatu.worlds.SplashScreenWorld;

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
		org.flashdevelop.utils.FlashConnect.redirect();
		if (flash.system.Capabilities.isDebugger)
		#end
		{
			HXP.console.enable();
			HXP.console.toggleKey = Key.P;
		}
		HXP.world = new GameWorld(LevelManager.levelNames[LevelManager.levelNames.length - 1]);
	#else
		HXP.world = new SplashScreenWorld();
	#end
		
		HXP.screen.color = clearColor;
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
		
		HXP.resize(800, 480);

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
