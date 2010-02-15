package com.codeazur.as3swf.data
{
	import com.codeazur.as3swf.SWFData;
	
	public class SWFMorphGradientRecord
	{
		public var startRatio:uint;
		public var startColor:uint;
		public var endRatio:uint;
		public var endColor:uint;
		
		public function SWFMorphGradientRecord(data:SWFData = null) {
			if (data != null) {
				parse(data);
			}
		}
		
		public function parse(data:SWFData):void {
			startRatio = data.readUI8();
			startColor = data.readRGBA();
			endRatio = data.readUI8();
			endColor = data.readRGBA();
		}
		
		public function publish(data:SWFData):void {
			data.writeUI8(startRatio);
			data.writeRGBA(startColor);
			data.writeUI8(endRatio);
			data.writeRGBA(endColor);
		}
		
		public function toString():String {
			return "[" + startRatio + "," + startColor.toString(16) + "," + endRatio + "," + endColor.toString(16) + "]";
		}
	}
}
