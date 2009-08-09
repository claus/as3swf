package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.SWFRectangle;
	
	public class TagDefineShape4 extends TagDefineShape3 implements ITag
	{
		public static const TYPE:uint = 83;
		
		public var edgeBounds:SWFRectangle;
		public var usesFillWindingRule:Boolean;
		public var usesNonScalingStrokes:Boolean;
		public var usesScalingStrokes:Boolean;

		public function TagDefineShape4() {}
		
		override public function parse(data:SWFData, length:uint, version:uint):void {
			shapeId = data.readUI16();
			shapeBounds = data.readRECT();
			edgeBounds = data.readRECT();
			var flags:uint = data.readUI8();
			usesFillWindingRule = ((flags & 0x04) != 0);
			usesNonScalingStrokes = ((flags & 0x02) != 0);
			usesScalingStrokes = ((flags & 0x01) != 0);
			shapes = data.readSHAPEWITHSTYLE(4);
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "DefineShape4"; }
		
		override public function toString(indent:uint = 0):String {
			var str:String = toStringMain(indent) +
				"ID: " + shapeId + ", " +
				"ShapeBounds: " + shapeBounds + ", " +
				"EdgeBounds: " + edgeBounds;
			str += shapes.toString(indent + 2);
			return str;
		}
	}
}
