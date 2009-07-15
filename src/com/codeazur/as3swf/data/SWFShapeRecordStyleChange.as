package com.codeazur.as3swf.data
{
	public class SWFShapeRecordStyleChange extends SWFShapeRecord
	{
		public var stateNewStyles:Boolean;
		public var stateLineStyle:Boolean;
		public var stateFillStyle1:Boolean;
		public var stateFillStyle0:Boolean;
		public var stateMoveTo:Boolean;
		
		public var moveDeltaX:int = 0;
		public var moveDeltaY:int = 0;
		public var fillStyle0:uint = 0;
		public var fillStyle1:uint = 0;
		public var lineStyle:uint = 0;
		public var numFillBits:uint = 0;
		public var numLineBits:uint = 0;

		protected var _fillStyles:Vector.<SWFFillStyle>;
		protected var _lineStyles:Vector.<SWFLineStyle>;

		public function SWFShapeRecordStyleChange(states:uint)
		{
			stateNewStyles = ((states & 0x10) != 0);
			stateLineStyle = ((states & 0x08) != 0);
			stateFillStyle1 = ((states & 0x04) != 0);
			stateFillStyle0 = ((states & 0x02) != 0);
			stateMoveTo = ((states & 0x01) != 0);
			
			_fillStyles = new Vector.<SWFFillStyle>();
			_lineStyles = new Vector.<SWFLineStyle>();
		}
		
		public function get fillStyles():Vector.<SWFFillStyle> { return _fillStyles; }
		public function get lineStyles():Vector.<SWFLineStyle> { return _lineStyles; }
		
		override public function get type():uint { return SWFShapeRecord.TYPE_STYLECHANGE; }
		
		override public function toString():String {
			var str:String = "[SWFShapeRecordStyleChange] ";
			if (stateMoveTo) { str += "MoveTo (dx:" + moveDeltaX + ",dy:" + moveDeltaY + ") "; }
			if (stateFillStyle0) { str += "FillStyle0 (0x" + fillStyle0.toString(16) + ") "; }
			if (stateFillStyle1) { str += "FillStyle1 (0x" + fillStyle1.toString(16) + ") "; }
			if (stateLineStyle) { str += "LineStyle (0x" + lineStyle.toString(16) + ") "; }
			if (stateNewStyles) { str += "NewStyles (fill:" + fillStyles.length + ",line:" + lineStyles.length + ") "; }
			return str;
		}
	}
}
