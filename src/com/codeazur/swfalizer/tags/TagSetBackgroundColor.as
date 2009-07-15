package com.codeazur.swfalizer.tags
{
	import com.codeazur.swfalizer.ISWFDataInput;
	import com.codeazur.utils.StringUtils;
	
	public class TagSetBackgroundColor extends Tag implements ITag
	{
		public static const TYPE:uint = 9;
		
		public var color:uint;
		
		public function TagSetBackgroundColor() {}
		
		public function parse(data:ISWFDataInput, length:uint):void {
			color = data.readRGB();
		}
		
		public function toString(indent:uint = 0):String {
			return StringUtils.repeat(indent) + "[" + StringUtils.printf("%02d", TYPE) + ":TagSetBackgroundColor] " +
				"Color: " + color.toString(16);
		}
	}
}
