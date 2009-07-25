package com.codeazur.as3swf.data
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.utils.StringUtils;
	
	public class SWFShape
	{
		protected var _records:Vector.<SWFShapeRecord>;
		
		public function SWFShape(data:SWFData = null, level:uint = 1) {
			_records = new Vector.<SWFShapeRecord>();
			if (data != null) {
				parse(data, level);
			}
		}
		
		public function get records():Vector.<SWFShapeRecord> { return _records; }

		public function parse(data:SWFData, level:uint = 1):void {
			data.resetBitsPending();
			var numFillBits:uint = data.readUB(4);
			var numLineBits:uint = data.readUB(4);
			readShapeRecords(data, numFillBits, numLineBits, level);
		}
		
		protected function readShapeRecords(data:SWFData, fillBits:uint, lineBits:uint, level:uint = 1):void {
			var shapeRecord:SWFShapeRecord;
			while (!(shapeRecord is SWFShapeRecordEnd)) {
				// The SWF10 spec says that shape records are byte aligned.
				// In reality they seem not to be?
				// bitsPending = 0;
				var edgeRecord:Boolean = (data.readUB(1) == 1);
				if (edgeRecord) {
					var straightFlag:Boolean = (data.readUB(1) == 1);
					var numBits:uint = data.readUB(4) + 2;
					if (straightFlag) {
						shapeRecord = data.readSTRAIGHTEDGERECORD(numBits);
					} else {
						shapeRecord = data.readCURVEDEDGERECORD(numBits);
					}
				} else {
					var states:uint = data.readUB(5);
					if (states == 0) {
						shapeRecord = new SWFShapeRecordEnd();
					} else {
						var styleChangeRecord:SWFShapeRecordStyleChange = data.readSTYLECHANGERECORD(states, fillBits, lineBits, level);
						if (styleChangeRecord.stateNewStyles) {
							// TODO: We might have to update fillStyles and lineStyles too
							fillBits = styleChangeRecord.numFillBits;
							lineBits = styleChangeRecord.numLineBits;
						}
						shapeRecord = styleChangeRecord;
					}
				}
				_records.push(shapeRecord);
			}
		}

		public function toString(indent:uint = 0):String {
			var str:String = "\n" + StringUtils.repeat(indent) + "Shapes:";
			for (var i:uint = 0; i < _records.length; i++) {
				str += "\n" + StringUtils.repeat(indent + 2) + _records[i].toString(indent + 2);
			}
			return str;
		}
	}
}
