package com.haxepunk.tmx;
import com.haxepunk.HXP;
import nme.geom.Point;
import haxe.xml.Fast;

/**
 * A TmxObject with a <polyline> node.
 * @author Princess Buccaneer */
class TmxPolygon extends TmxShape {
	
	public function new(source:Fast, parent:TmxObjectGroup) {
		super(source, parent);

		var pointStrings = source.node.polygon.att.points.split(" ");
		for (point in pointStrings) {
			var xy: Array<String> = point.split(",");
			points.push(new Point(x + Std.parseFloat(xy[0]), y + Std.parseFloat(xy[1])));
		}
	}
	
}