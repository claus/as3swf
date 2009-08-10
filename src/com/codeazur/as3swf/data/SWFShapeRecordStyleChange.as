package com.codeazur.as3swf.data
{
	import com.codeazur.as3swf.SWFData;
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

		public function SWFShapeRecordStyleChange(data:SWFData = null, states:uint = 0, fillBits:uint = 0, lineBits:uint = 0, level:uint = 1) {
			_fillStyles = new Vector.<SWFFillStyle>();
			_lineStyles = new Vector.<SWFLineStyle>();
			stateNewStyles = ((states & 0x10) != 0);
			stateLineStyle = ((states & 0x08) != 0);
			stateFillStyle1 = ((states & 0x04) != 0);
			stateFillStyle0 = ((states & 0x02) != 0);
			stateMoveTo = ((states & 0x01) != 0);
			numFillBits = fillBits;
			numLineBits = lineBits;
			super(data, level);
		}
		
		public function get fillStyles():Vector.<SWFFillStyle> { return _fillStyles; }
		public function get lineStyles():Vector.<SWFLineStyle> { return _lineStyles; }
		
		override public function get type():uint { return SWFShapeRecord.TYPE_STYLECHANGE; }
		
		override public function parse(data:SWFData = null, level:uint = 1):void {
			if (stateMoveTo) {
				var moveBits:uint = data.readUB(5);
				moveDeltaX = data.readSB(moveBits);
				moveDeltaY = data.readSB(moveBits);
			}
			fillStyle0 = stateFillStyle0 ? data.readUB(numFillBits) : 0;
			fillStyle1 = stateFillStyle1 ? data.readUB(numFillBits) : 0;
			lineStyle = stateLineStyle ? data.readUB(numLineBits) : 0;
			if (stateNewStyles) {
				data.resetBitsPending();
				var i:uint;
				var fillStylesLen:uint = readStyleArrayLength(data, level);
				for (i = 0; i < fillStylesLen; i++) {
					fillStyles.push(data.readFILLSTYLE(level));
				}
				var lineStylesLen:uint = readStyleArrayLength(data, level);
				for (i = 0; i < lineStylesLen; i++) {
					lineStyles.push(level <= 3 ? data.readLINESTYLE(level) : data.readLINESTYLE2(level));
				}
				numFillBits = data.readUB(4);
				numLineBits = data.readUB(4);
			}
		}
		
		protected function readStyleArrayLength(data:SWFData, level:uint = 1):uint {
			var len:uint = data.readUI8();
			if (level >= 2 && len == 0xff) {
				len = data.readUI16();
			}
			return len;
		}
		
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
						str += "\n" + StringUtils.repeat(indent + 4) + "[" + (i + 1) + "] " + _fillStyles[i].toString();
					}
				}
				if (_lineStyles.length > 0) {
					str += "\n" + StringUtils.repeat(indent + 2) + "New LineStyles:";
					for (i = 0; i < _lineStyles.length; i++) {
						str += "\n" + StringUtils.repeat(indent + 4) + "[" + (i + 1) + "] " + _lineStyles[i].toString();
					}
				}
			}
			return str;
		}
	}
}
