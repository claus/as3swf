package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.ISWFDataInput;
	import com.codeazur.utils.StringUtils;
	
	public class TagDefineShape2 extends TagDefineShape implements ITag
	{
		public static const TYPE:uint = 22;
		
		public function TagDefineShape2() {}
		
		override public function parse(data:ISWFDataInput, length:uint):void {
			shapeId = data.readUI16();
			shapeBounds = data.readRECT();
			shapes = data.readSHAPEWITHSTYLE(2);
		}
		
		override public function toString(indent:uint = 0):String {
			return StringUtils.repeat(indent) + "[" + StringUtils.printf("%02d", TYPE) + ":TagDefineShape2] " +
				"ID: " + shapeId + ", " +
				"Bounds: " + shapeBounds;
		}
	}
}
