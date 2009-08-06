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
		public function get version():uint { return 0; }
		public function get length():uint { return _raw.length; }
		public function get raw():ByteArray { return _raw; }
		
		// this will probably go away as soon as all tags can publish
		public function cache(data:SWFData, length:uint):void {
			if (length > 0) {
				var pos:uint = data.position;
				data.readBytes(_raw, 0, length);
				data.position = pos;
			}
		}
		
		public function publish(data:SWFData):void {
			data.writeTagHeader(type, length);
			data.writeBytes(_raw, 0, length);
		}
		
		protected function toStringMain(indent:uint = 0):String {
			return StringUtils.repeat(indent) + "[" + StringUtils.printf("%02d", type) + ":" + name + "] ";
		}
	}
}
