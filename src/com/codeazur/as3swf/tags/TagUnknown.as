package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.ISWFDataInput;
	import com.codeazur.as3swf.data.SWFRecordHeader;
	import com.codeazur.utils.StringUtils;
	
	import flash.utils.ByteArray;
	
	public class TagUnknown extends Tag implements ITag
	{
		public var type:uint;
		public var length:uint;
		
		protected var _raw:ByteArray;
		
		public function TagUnknown() {
			_raw = new ByteArray();
		}
		
		public function get raw():ByteArray { return _raw; }
		
		public function parse(data:ISWFDataInput, length:uint):void {
			this.length = length;
			if (length > 0) {
				data.readBytes(raw, 0, length);
			}
		}
		
		public function toString(indent:uint = 0):String {
			return StringUtils.repeat(indent) + "[" + StringUtils.printf("%02d", type) + ",????] Length: " + length;
		}
	}
}
