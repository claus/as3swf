package com.codeazur.swfalizer.data
{
	public class SWFKerningRecord extends SWFShapeRecord
	{
		public var code1:uint;
		public var code2:uint;
		public var adjustment:int;

		public function SWFKerningRecord(code1:uint, code2:uint, adjustment:int)
		{
			this.code1 = code1;
			this.code2 = code2;
			this.adjustment = adjustment;
		}
		
		override public function toString():String {
			return "[SWFKerningRecord] " +
				"Code1: " + code1 + ", " +
				"Code2: " + code2 + ", " +
				"Adjustment: " + adjustment;
		}
	}
}
