package com.codeazur.as3swf.data
{
	public class SWFShapeRecordCurvedEdge extends SWFShapeRecord
	{
		public var controlDeltaX:int;
		public var controlDeltaY:int;
		public var anchorDeltaX:int;
		public var anchorDeltaY:int;

		public function SWFShapeRecordCurvedEdge(controlDeltaX:int, controlDeltaY:int, anchorDeltaX:int, anchorDeltaY:int)
		{
			this.controlDeltaX = controlDeltaX;
			this.controlDeltaY = controlDeltaY;
			this.anchorDeltaX = anchorDeltaX;
			this.anchorDeltaY = anchorDeltaY;
		}
		
		override public function get type():uint { return SWFShapeRecord.TYPE_CURVEDEDGE; }
		
		override public function toString(indent:uint = 0):String {
			return "[SWFShapeRecordCurvedEdge] " +
				"ControlDelta: " + controlDeltaX + "," + controlDeltaY + ", " +
				"AnchorDelta: " + anchorDeltaX + "," + anchorDeltaY;
		}
	}
}
