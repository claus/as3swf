package com.codeazur.swfalizer.data
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
			return "[SWFGradientRecord] Ratio: " + ratio + ", Color: " + color;
		}
	}
}
