package com.codeazur.as3swf.data
{
	import com.codeazur.as3swf.ISWFDataInput;
	
	public class SWFLineStyle
	{
		public var width:uint;
		public var color:uint;
		
		public function SWFLineStyle(data:ISWFDataInput = null, level:uint = 1) {
			if (data != null) {
				parse(data, level);
			}
		}
		
		public function parse(data:ISWFDataInput, level:uint = 1):void {
			width = data.readUI16();
			color = (level <= 2) ? data.readRGB() : data.readRGBA();
		}
		
		public function toString():String {
			return "[SWFLineStyle] Width: " + width + " Color: " + color.toString(16);
		}
	}
}
