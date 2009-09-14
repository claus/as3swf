package com.codeazur.as3swf.data
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.exporters.IShapeExportDocumentHandler;
	
	import com.codeazur.utils.StringUtils;
	
	public class SWFShapeWithStyle extends SWFShape
	{
		protected var _fillStyles:Vector.<SWFFillStyle>;
		protected var _lineStyles:Vector.<SWFLineStyle>;
		
		public function SWFShapeWithStyle(data:SWFData = null, level:uint = 1) {
			_fillStyles = new Vector.<SWFFillStyle>();
			_lineStyles = new Vector.<SWFLineStyle>();
			super(data, level);
		}
		
		public function get fillStyles():Vector.<SWFFillStyle> { return _fillStyles; }
		public function get lineStyles():Vector.<SWFLineStyle> { return _lineStyles; }
		
		override public function parse(data:SWFData, level:uint = 1):void {
			data.resetBitsPending();
			var i:uint;
			var fillStylesLen:uint = readStyleArrayLength(data, level);
			for (i = 0; i < fillStylesLen; i++) {
				_fillStyles.push(data.readFILLSTYLE(level));
			}
			var lineStylesLen:uint = readStyleArrayLength(data, level);
			for (i = 0; i < lineStylesLen; i++) {
				_lineStyles.push(level <= 3 ? data.readLINESTYLE(level) : data.readLINESTYLE2(level));
			}
			var numFillBits:uint = data.readUB(4);
			var numLineBits:uint = data.readUB(4);
			data.resetBitsPending();
			readShapeRecords(data, numFillBits, numLineBits, level);
		}
		
		override public function export(handler:IShapeExportDocumentHandler = null):void {
			tmpFillStyles = _fillStyles.concat();
			tmpLineStyles = _lineStyles.concat();
			super.export(handler);
			tmpFillStyles = null;
			tmpLineStyles = null;
		}

		override public function toString(indent:uint = 0):String {
			var i:uint;
			var str:String = "";
			if (_fillStyles.length > 0) {
				str += "\n" + StringUtils.repeat(indent) + "FillStyles:";
				for (i = 0; i < _fillStyles.length; i++) {
					str += "\n" + StringUtils.repeat(indent + 2) + "[" + (i + 1) + "] " + _fillStyles[i].toString();
				}
			}
			if (_lineStyles.length > 0) {
				str += "\n" + StringUtils.repeat(indent) + "LineStyles:";
				for (i = 0; i < _lineStyles.length; i++) {
					str += "\n" + StringUtils.repeat(indent + 2) + "[" + (i + 1) + "] " + _lineStyles[i].toString();
				}
			}
			return str + super.toString(indent);
		}
		
		protected function readStyleArrayLength(data:SWFData, level:uint = 1):uint {
			var len:uint = data.readUI8();
			if (level >= 2 && len == 0xff) {
				len = data.readUI16();
			}
			return len;
		}
	}
}
