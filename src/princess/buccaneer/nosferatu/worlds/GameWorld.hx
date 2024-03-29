package princess.buccaneer.nosferatu.worlds;
import com.haxepunk.HXP;
import com.haxepunk.tmx.TmxEntity;
import com.haxepunk.tmx.TmxObjectGroup;
import com.haxepunk.World;
import com.haxepunk.Entity;
import nme.geom.Rectangle;
import princess.buccaneer.nosferatu.ai.FollowPolygonBehavior;
import princess.buccaneer.nosferatu.ai.FollowPolylineBehavior;
import princess.buccaneer.nosferatu.ai.StationaryBehavior;
import princess.buccaneer.nosferatu.ui.HealthBar;
import princess.buccaneer.nosferatu.ui.TextDisplay;
import princess.buccaneer.nosferatu.ui.LevelComplete;

import princess.buccaneer.nosferatu.lighting.LitWorld;
import princess.buccaneer.nosferatu.lighting.FloodLight;
import princess.buccaneer.nosferatu.entities.PlayerEntity;
import princess.buccaneer.nosferatu.entities.EnemyEntity;

/**
 * The main game world.
 * @author Princess Buccaneer */
class GameWorld extends LitWorld {
	
	public static var world: GameWorld;

	var tiles: TmxEntity;
	public var player: PlayerEntity;
	public var enemies: Array<EnemyEntity>;
	
	override public function begin() {
		super.begin();
		world = this;
		add(new SoundManager());
		add(player);
		add(new HealthBar());
	}

	public function new(mapData:Dynamic) {
		super();
		
		enemies = new Array<EnemyEntity>();
		tiles = new TmxEntity(mapData);
		tiles.loadGraphic("gfx/tilemap.png", ["main", "decoration", "decoration2", "decoration3"]);
		// tiles.loadGraphic("gfx/solid32.png", ["collide"]); // for debugging
		tiles.loadMask();
		add(tiles);
		
		for (objectGroup in tiles.map.objectGroups) {
			for (object in objectGroup.objects) {
				switch(object.type) {
					case "player":
						player = new PlayerEntity();
						player.x = object.x;
						player.y = object.y;
					case "light":
						var sRadius = object.custom.resolve("radius");
						if (sRadius == null) {
							trace("Light at " + object.x + ", " + object.y + " with no radius!");
							break;
						}
						var light = new FloodLight(Std.parseInt(sRadius));
						light.x = object.x;
						light.y = object.y;
						add(light);
					case "enemy":
						var enemy = new EnemyEntity();
						enemy.x = object.x;
						enemy.y = object.y;
						enemy.xdirection = Std.parseFloat(object.custom.xdirection != null ? object.custom.xdirection : "");
						enemy.ydirection = Std.parseFloat(object.custom.ydirection != null ? object.custom.ydirection : "");
						enemy.behavior = new StationaryBehavior();
						enemies.push(enemy);
						add(enemy);
					case "text":
						add(new TextDisplay(object.custom.text));
				}
			}
			for (polygon in objectGroup.polygons) {
				switch (polygon.type) {
					case "enemy_path":
						var enemy = new EnemyEntity();
						enemy.x = polygon.points[0].x;
						enemy.y = polygon.points[0].y;
						enemies.push(enemy);
						var b = new FollowPolygonBehavior();
						b.polygon = polygon.points;
						enemy.behavior = b;
						add(enemy);
				}
			}
			for (polyline in objectGroup.polylines) {
				switch (polyline.type) {
					case "enemy_path":
						var enemy = new EnemyEntity();
						enemy.x = polyline.points[0].x;
						enemy.y = polyline.points[0].y;
						enemies.push(enemy);
						var b = new FollowPolylineBehavior();
						b.polyline = polyline.points;
						enemy.behavior = b;
						add(enemy);
				}
			}
		}
		
		if (player == null) {
			trace("ERROR: no player! creating one at (0,0)");
			player = new PlayerEntity();
		}
	}
	
	override public function update() {
		super.update();
		var entities: Array<Entity> = new Array<Entity>();
		getAll(entities);
		for (entity in entities)
			if (Std.is(entity, EnemyEntity) || Std.is(entity, LevelComplete)) return;
		LevelManager.complete();
	}
	
}