package com.codeazur.swfalizer.tags
{
	import com.codeazur.swfalizer.ISWFDataInput;
	import com.codeazur.swfalizer.data.SWFRectangle;
	import com.codeazur.swfalizer.data.SWFShapeWithStyle;
	import com.codeazur.utils.StringUtils;
	
	public class TagDefineShape extends Tag implements ITag
	{
		public static const TYPE:uint = 2;
		
		public var shapeId:uint;
		public var shapeBounds:SWFRectangle;
		public var shapes:SWFShapeWithStyle;
		
		public function TagDefineShape() {}
		
		public function parse(data:ISWFDataInput, length:uint):void {
			shapeId = data.readUI16();
			shapeBounds = data.readRECT();
			shapes = data.readSHAPEWITHSTYLE();
		}
		
		public function toString(indent:uint = 0):String {
			return StringUtils.repeat(indent) + "[" + StringUtils.printf("%02d", TYPE) + ":TagDefineShape] " +
				"ID: " + shapeId + ", " +
				"Bounds: " + shapeBounds;
		}
	}
}
