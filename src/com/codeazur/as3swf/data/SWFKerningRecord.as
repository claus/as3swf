package com.codeazur.as3swf.data
{
	public class SWFKerningRecord
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
		
		public function toString(indent:uint = 0):String {
			return "[SWFKerningRecord] " +
				"Code1: " + code1 + ", " +
				"Code2: " + code2 + ", " +
				"Adjustment: " + adjustment;
		}
	}
}
