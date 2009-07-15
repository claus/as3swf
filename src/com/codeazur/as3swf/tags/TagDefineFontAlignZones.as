package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.ISWFDataInput;
	import com.codeazur.as3swf.data.SWFZoneRecord;
	import com.codeazur.utils.StringUtils;
	
	public class TagDefineFontAlignZones extends Tag implements ITag
	{
		public static const TYPE:uint = 73;
		
		public static const CSMTABLEHINT_THIN:uint = 0;
		public static const CSMTABLEHINT_MEDIUM:uint = 1;
		public static const CSMTABLEHINT_THICK:uint = 2;
		
		public var fontId:uint;
		public var csmTableHint:uint;
		
		protected var _zoneTable:Vector.<SWFZoneRecord>;
		
		public function TagDefineFontAlignZones() {
			_zoneTable = new Vector.<SWFZoneRecord>();
		}
		
		public function get zoneTable():Vector.<SWFZoneRecord> { return _zoneTable; }
		
		public function parse(data:ISWFDataInput, length:uint):void {
			fontId = data.readUI16();
			csmTableHint = (data.readUI8() >> 6);
			var recordsEndPos:uint = data.position + length - 3;
			while (data.position < recordsEndPos) {
				_zoneTable.push(data.readZONERECORD());
			}
		}
		
		public function toString(indent:uint = 0):String {
			return StringUtils.repeat(indent) + "[" + StringUtils.printf("%02d", TYPE) + ":TagDefineFontAlignZones] " +
				"FontID: " + fontId + ", " +
				"CSMTableHint: " + csmTableHint + ", " +
				"Records: " + _zoneTable.length;
		}
	}
}
