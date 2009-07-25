package com.codeazur.as3swf.data
{
	import com.codeazur.as3swf.SWFData;
	
	public class SWFShapeRecordStraightEdge extends SWFShapeRecord
	{
		public var generalLineFlag:Boolean;
		public var vertLineFlag:Boolean;
		public var deltaY:int;
		public var deltaX:int;
		
		protected var numBits:uint;

		public function SWFShapeRecordStraightEdge(data:SWFData = null, numBits:uint = 0, level:uint = 1) {
			this.numBits = numBits;
			super(data, level);
		}
		
		override public function parse(data:SWFData = null, level:uint = 1):void {
			generalLineFlag = (data.readUB(1) == 1);
			vertLineFlag = !generalLineFlag ? (data.readSB(1) != 0) : false;
			deltaX = (generalLineFlag || !vertLineFlag) ? data.readSB(numBits) : 0;
			deltaY = (generalLineFlag || vertLineFlag) ? data.readSB(numBits) : 0;
		}
		
		override public function get type():uint { return SWFShapeRecord.TYPE_STRAIGHTEDGE; }
		
		override public function toString(indent:uint = 0):String {
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
