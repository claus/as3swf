package com.codeazur.as3swf.data
{
	public class SWFGradientRecord
	{
		public var ratio:uint;
		public var color:uint;
		
		public function SWFGradientRecord(ratio:uint, color:uint)
		{
			this.ratio = ratio;
			this.color = color;
		}
		
		public function toString():String {
			return "[" + ratio + "," + color.toString(16) + "]";
		}
	}
}
