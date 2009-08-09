package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.SWFMatrix;
	import com.codeazur.as3swf.data.SWFRectangle;
	import com.codeazur.as3swf.data.SWFTextRecord;
	import com.codeazur.utils.StringUtils;
	
	public class TagDefineText extends Tag implements ITag
	{
		public static const TYPE:uint = 11;
		
		public var characterId:uint;
		public var textBounds:SWFRectangle;
		public var textMatrix:SWFMatrix;
		
		protected var _records:Vector.<SWFTextRecord>;
		
		public function TagDefineText() {
			_records = new Vector.<SWFTextRecord>();
		}
		
		public function get records():Vector.<SWFTextRecord> { return _records; }
		
		public function parse(data:SWFData, length:uint, version:uint):void {
			characterId = data.readUI16();
			textBounds = data.readRECT();
			textMatrix = data.readMATRIX();
			var glyphBits:uint = data.readUI8();
			var advanceBits:uint = data.readUI8();
			var record:SWFTextRecord;
			while ((record = data.readTEXTRECORD(glyphBits, advanceBits, record)) != null) {
				_records.push(record);
			}
		}
		
		public function publish(data:SWFData, version:uint):void {
			throw(new Error("TODO: implement publish()"));
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "DefineText"; }
		
		public function toString(indent:uint = 0):String {
			var str:String = toStringMain(indent) +
				"ID: " + characterId + ", " +
				"Bounds: " + textBounds + ", " +
				"Matrix: " + textMatrix;
			if (_records.length > 0) {
				str += "\n" + StringUtils.repeat(indent + 2) + "TextRecords:";
				for (var i:uint = 0; i < _records.length; i++) {
					str += "\n" + StringUtils.repeat(indent + 4) + "[" + i + "] " + _records[i].toString();
				}
			}
			return str;
		}
	}
}
