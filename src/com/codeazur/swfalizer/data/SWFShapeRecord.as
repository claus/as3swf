package com.codeazur.swfalizer.data
{
	public class SWFShapeRecord
	{
		public static const TYPE_UNKNOWN:uint = 0;
		public static const TYPE_END:uint = 1;
		public static const TYPE_STYLECHANGE:uint = 2;
		public static const TYPE_STRAIGHTEDGE:uint = 3;
		public static const TYPE_CURVEDEDGE:uint = 4;
		
		public function SWFShapeRecord() {}
		
		public function get type():uint { return TYPE_UNKNOWN; }
		
		public function toString():String {
			return "[SWFShapeRecord]";
		}
	}
}
