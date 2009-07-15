package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.ISWFDataInput;
	import com.codeazur.as3swf.data.SWFRecordHeader;
	
	public class Tag
	{
		public static function parseHeader(data:ISWFDataInput):SWFRecordHeader {
			var typeAndLength:uint = data.readUI16();
			var length:uint = typeAndLength & 0x3f;
			if (length == 0x3f) {
				length = data.readSI32();
			}
			return new SWFRecordHeader(typeAndLength >> 6, length);
		}
	}
}
