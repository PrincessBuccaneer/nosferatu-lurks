/*******************************************************************************
 * Copyright (c) 2011 by Matt Tuttle (original by Thomas Jahn)
 * This content is released under the MIT License.
 * For questions mail me at heardtheword@gmail.com
 ******************************************************************************/
package com.haxepunk.tmx;
import com.haxepunk.Entity;
import haxe.xml.Fast;
import com.haxepunk.HXP;

class TmxObjectGroup extends Entity {
	public var map:TmxMap;
	public var opacity:Float;
	public var properties:TmxPropertySet;
	public var objects:Array<TmxObject>;
	public var polygons:Array<TmxPolygon>;
	public var polylines:Array<TmxPolyline>;
	
	public function new(source:Fast, parent:TmxMap)	{
		super();
		properties = new TmxPropertySet();
		objects = new Array<TmxObject>();
		polygons = new Array<TmxPolygon>();
		polylines = new Array<TmxPolyline>();
		
		map = parent;
		name = source.att.name;
		x = (source.has.x) ? Std.parseInt(source.att.x) : 0;
		y = (source.has.y) ? Std.parseInt(source.att.y) : 0;
		width = Std.parseInt(source.att.width);
		height = Std.parseInt(source.att.height);
		visible = (source.has.visible && source.att.visible == "1") ? true : false;
		opacity = (source.has.opacity) ? Std.parseFloat(source.att.opacity) : 0;
		
		//load properties
		var node:Fast;
		for (node in source.nodes.properties)
			properties.extend(node);
			
		//load objects
		for (node in source.nodes.object)
			if (node.hasNode.polygon) {
				var polygon = new TmxPolygon(node, this);
				objects.push(polygon);
				polygons.push(polygon);
			}
			else if (node.hasNode.polyline) {
				var polyline = new TmxPolyline(node, this);
				objects.push(polyline);
				polylines.push(polyline);
			}
			else objects.push(new TmxObject(node, this));
			
	}
	
	public override function added() {
		for (object in objects)
			HXP.world.add(object);
		HXP.world.remove(this);
	}
}