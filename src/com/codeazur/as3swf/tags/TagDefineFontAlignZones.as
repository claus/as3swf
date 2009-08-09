package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.SWFZoneRecord;
	import com.codeazur.as3swf.data.consts.CSMTableHint;
	import com.codeazur.utils.StringUtils;
	
	public class TagDefineFontAlignZones extends Tag implements ITag
	{
		public static const TYPE:uint = 73;
		
		public var fontId:uint;
		public var csmTableHint:uint;
		
		protected var _zoneTable:Vector.<SWFZoneRecord>;
		
		public function TagDefineFontAlignZones() {
			_zoneTable = new Vector.<SWFZoneRecord>();
		}
		
		public function get zoneTable():Vector.<SWFZoneRecord> { return _zoneTable; }
		
		public function parse(data:SWFData, length:uint, version:uint):void {
			fontId = data.readUI16();
			csmTableHint = (data.readUI8() >> 6);
			var recordsEndPos:uint = data.position + length - 3;
			while (data.position < recordsEndPos) {
				_zoneTable.push(data.readZONERECORD());
			}
		}
		
		public function publish(data:SWFData, version:uint):void {
			throw(new Error("TODO: implement publish()"));
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "DefineFontAlignZones"; }
		
		public function toString(indent:uint = 0):String {
			var str:String = toStringMain(indent) +
				"FontID: " + fontId + ", " +
				"CSMTableHint: " + CSMTableHint.toString(csmTableHint) + ", " +
				"Records: " + _zoneTable.length;
			for (var i:uint = 0; i < _zoneTable.length; i++) {
				str += "\n" + StringUtils.repeat(indent + 2) + "[" + i + "] " + _zoneTable[i].toString(indent + 2);
			}
			return str;
		}
	}
}
