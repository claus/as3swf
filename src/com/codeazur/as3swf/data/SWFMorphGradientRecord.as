package com.codeazur.as3swf.data
{
	import com.codeazur.as3swf.SWFData;
	
	public class SWFMorphGradientRecord
	{
		public var startRatio:uint;
		public var startColor:uint;
		public var endRatio:uint;
		public var endColor:uint;
		
		public function SWFMorphGradientRecord(data:SWFData = null, level:uint = 1) {
			if (data != null) {
				parse(data, level);
			}
		}
		
		public function parse(data:SWFData, level:uint):void {
			startRatio = data.readUI8();
			startColor = data.readRGBA();
			endRatio = data.readUI8();
			endColor = data.readRGBA();
		}
		
		public function toString():String {
			return "[" + startRatio + "," + startColor.toString(16) + "," + endRatio + "," + endColor.toString(16) + "]";
		}
	}
}
