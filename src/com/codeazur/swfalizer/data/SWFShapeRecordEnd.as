package com.codeazur.swfalizer.data
{
	public class SWFShapeRecordEnd extends SWFShapeRecord
	{
		public function SWFShapeRecordEnd() {}
		
		override public function get type():uint { return SWFShapeRecord.TYPE_END; }
		
		override public function toString():String {
			return "[SWFShapeRecordEnd]";
		}
	}
}
