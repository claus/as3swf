package com.codeazur.swfalizer.data
{
	public class SWFShapeRecordStraightEdge extends SWFShapeRecord
	{
		public var generalLineFlag:Boolean;
		public var vertLineFlag:Boolean;
		public var deltaY:int;
		public var deltaX:int;

		public function SWFShapeRecordStraightEdge(generalLineFlag:Boolean, vertLineFlag:Boolean, deltaX:int, deltaY:int)
		{
			this.generalLineFlag = generalLineFlag;
			this.vertLineFlag = vertLineFlag;
			this.deltaX = deltaX;
			this.deltaY = deltaY;
		}
		
		override public function get type():uint { return SWFShapeRecord.TYPE_STRAIGHTEDGE; }
		
		override public function toString():String {
			var str:String = "[SWFShapeRecordStraightEdge] ";
			if (generalLineFlag) {
				str += "General: " + deltaX + "," + deltaY;
			} else {
				if (vertLineFlag) {
					str += "Vertical: " + deltaY;
				} else {
					str += "Horizontal: " + deltaX;
				}
			}
			return str;
		}
	}
}
