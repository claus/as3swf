package com.codeazur.as3swf.tags
{
	import com.codeazur.utils.StringUtils;
	
	import flash.utils.ByteArray;
	
	public class Tag
	{
		protected var _type:uint;
		protected var _raw:ByteArray;
		
		public function Tag() {}
		
		public function get type():uint { return _type; }
		public function get name():String { return "????"; }
		public function get version():uint { return 0; }
		
		public function get raw():ByteArray { return _raw; }
		public function set raw(value:ByteArray):void { _raw = value; }
		
		protected function toStringMain(indent:uint = 0):String {
			return StringUtils.repeat(indent) + "[" + StringUtils.printf("%02d", type) + ":" + name + "] ";
		}
	}
}
