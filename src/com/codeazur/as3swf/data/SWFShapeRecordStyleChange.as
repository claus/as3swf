package com.codeazur.as3swf.data
{
	import com.codeazur.utils.StringUtils;
	
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
		
		override public function toString(indent:uint = 0):String {
			var str:String = "[SWFShapeRecordStyleChange] ";
			var cmds:Array = [];
			if (stateMoveTo) { cmds.push("MoveTo: " + moveDeltaX + "," + moveDeltaY); }
			if (stateFillStyle0) { cmds.push("FillStyle0: " + fillStyle0); }
			if (stateFillStyle1) { cmds.push("FillStyle1: " + fillStyle1); }
			if (stateLineStyle) { cmds.push("LineStyle: " + lineStyle); }
			if (cmds.length > 0) { str += cmds.join(", "); }
			if (stateNewStyles) {
				var i:uint;
				if (_fillStyles.length > 0) {
					str += "\n" + StringUtils.repeat(indent + 2) + "New FillStyles:";
					for (i = 0; i < _fillStyles.length; i++) {
						str += "\n" + StringUtils.repeat(indent + 4) + "[" + i + "] " + _fillStyles[i].toString();
					}
				}
				if (_lineStyles.length > 0) {
					str += "\n" + StringUtils.repeat(indent + 2) + "New LineStyles:";
					for (i = 0; i < _lineStyles.length; i++) {
						str += "\n" + StringUtils.repeat(indent + 4) + "[" + i + "] " + _lineStyles[i].toString();
					}
				}
			}
			return str;
		}
	}
}
