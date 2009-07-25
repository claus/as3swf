package com.codeazur.as3swf.data
{
	import com.codeazur.as3swf.SWFData;
	
	public class SWFGradientRecord
	{
		public var ratio:uint;
		public var color:uint;
		
		public function SWFGradientRecord(data:SWFData = null, level:uint = 1) {
			if (data != null) {
				parse(data, level);
			}
		}
		
		public function parse(data:SWFData, level:uint):void {
			ratio = data.readUI8();
			color = (level <= 2) ? data.readRGB() : data.readRGBA();
		}
		
		public function toString():String {
			return "[" + ratio + "," + color.toString(16) + "]";
		}
	}
}
