package com.codeazur.swfalizer.data
{
	public class SWFGradient
	{
		public static const SPREAD_MODE_PAD:uint = 0;
		public static const SPREAD_MODE_REFLECT:uint = 1;
		public static const SPREAD_MODE_REPEAT:uint = 2;

		public static const INTERPOLATION_MODE_NORMAL:uint = 0;
		public static const INTERPOLATION_MODE_LINEAR:uint = 1;
		
		public var spreadMode:uint;
		public var interpolationMode:uint;
		public var focalPoint:Number = 0.0;
		
		protected var _records:Vector.<SWFGradientRecord>;
		
		public function SWFGradient(spreadMode:uint, interpolationMode:uint)
		{
			spreadMode = spreadMode;
			interpolationMode = interpolationMode;
			
			_records = new Vector.<SWFGradientRecord>();
		}
		
		public function get records():Vector.<SWFGradientRecord> { return _records; }
		
		public function toString():String {
			return "[SWFGradient]";
		}
	}
}
