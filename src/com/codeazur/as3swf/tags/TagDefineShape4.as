package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.ISWFDataInput;
	import com.codeazur.as3swf.data.SWFRectangle;
	import com.codeazur.utils.StringUtils;
	
	public class TagDefineShape4 extends TagDefineShape3 implements ITag
	{
		public static const TYPE:uint = 83;
		
		public var edgeBounds:SWFRectangle;
		public var usesFillWindingRule:Boolean;
		public var usesNonScalingStrokes:Boolean;
		public var usesScalingStrokes:Boolean;

		public function TagDefineShape4() {}
		
		override public function parse(data:ISWFDataInput, length:uint):void {
			shapeId = data.readUI16();
			shapeBounds = data.readRECT();
			edgeBounds = data.readRECT();
			var flags:uint = data.readUI8();
			usesFillWindingRule = ((flags & 0x04) != 0);
			usesNonScalingStrokes = ((flags & 0x02) != 0);
			usesScalingStrokes = ((flags & 0x01) != 0);
			shapes = data.readSHAPEWITHSTYLE(4);
		}
		
		override public function toString(indent:uint = 0):String {
			var str:String = StringUtils.repeat(indent) + "[" + StringUtils.printf("%02d", TYPE) + ":TagDefineShape4] " +
				"ID: " + shapeId + ", " +
				"ShapeBounds: " + shapeBounds + ", " +
				"EdgeBounds: " + edgeBounds;
			str += "\n" + StringUtils.repeat(indent + 2) + "Shapes:";
			str += shapes.toString(indent + 4);
			return str;
		}
	}
}
