package com.codeazur.as3swf.data
{
	import com.codeazur.as3swf.SWFData;
	
	public class SWFMorphLineStyle
	{
		public var startWidth:uint;
		public var endWidth:uint;
		public var startColor:uint;
		public var endColor:uint;
		
		public function SWFMorphLineStyle(data:SWFData = null, level:uint = 1) {
			if (data != null) {
				parse(data, level);
			}
		}
		
		public function parse(data:SWFData, level:uint = 1):void {
			startWidth = data.readUI16();
			endWidth = data.readUI16();
			startColor = data.readRGBA();
			endColor = data.readRGBA();
		}
		
		public function toString():String {
			return "[SWFMorphLineStyle] " +
				"StartWidth: " + startWidth + ", " +
				"EndWidth: " + endWidth + ", " +
				"StartColor: " + startColor.toString(16) + ", " +
				"EndColor: " + endColor.toString(16);
		}
	}
}
