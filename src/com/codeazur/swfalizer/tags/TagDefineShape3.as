package com.codeazur.swfalizer.tags
{
	import com.codeazur.swfalizer.ISWFDataInput;
	import com.codeazur.utils.StringUtils;
	
	public class TagDefineShape3 extends TagDefineShape2 implements ITag
	{
		public static const TYPE:uint = 32;
		
		public function TagDefineShape3() {}
		
		override public function parse(data:ISWFDataInput, length:uint):void {
			shapeId = data.readUI16();
			shapeBounds = data.readRECT();
			shapes = data.readSHAPEWITHSTYLE(3);
		}
		
		override public function toString(indent:uint = 0):String {
			return StringUtils.repeat(indent) + "[" + StringUtils.printf("%02d", TYPE) + ":TagDefineShape3] " +
				"ID: " + shapeId + ", " +
				"Bounds: " + shapeBounds;
		}
	}
}
