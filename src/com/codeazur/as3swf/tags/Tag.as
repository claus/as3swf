package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.SWFRecordHeader;
	import com.codeazur.utils.StringUtils;
	
	import flash.utils.ByteArray;
	
	public class Tag
	{
		protected var _raw:ByteArray;
		protected var _type:uint;
		
		public function Tag() {
			_raw = new ByteArray();
		}
		
		public function get type():uint { return _type; }
		public function get name():String { return "????"; }
		public function get length():uint { return _raw.length; }
		public function get raw():ByteArray { return _raw; }
		
		public function cache(data:SWFData, length:uint):void {
			if (length > 0) {
				var pos:uint = data.position;
				data.readBytes(_raw, 0, length);
				data.position = pos;
			}
		}
		
		public function publish(data:SWFData):void {
			writeHeader(data, new SWFRecordHeader(type, length));
			data.writeBytes(_raw, 0, length);
		}
		
		public static function readHeader(data:SWFData):SWFRecordHeader {
			var typeAndLength:uint = data.readUI16();
			var length:uint = typeAndLength & 0x3f;
			if (length == 0x3f) {
				length = data.readSI32();
			}
			return new SWFRecordHeader(typeAndLength >> 6, length);
		}

		public static function writeHeader(data:SWFData, header:SWFRecordHeader):void {
			var length:uint = header.length;
			if (header.length < 0x3f) {
				data.writeUI16((header.type << 6) | header.length);
			} else {
				data.writeUI16((header.type << 6) | 0x3f);
				data.writeSI32(header.length);
			}
		}
		
		protected function toStringMain(indent:uint = 0):String {
			return StringUtils.repeat(indent) + "[" + StringUtils.printf("%02d", type) + ":" + name + "] ";
		}
	}
}
