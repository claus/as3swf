package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.ISWFDataInput;
	import com.codeazur.utils.StringUtils;
	
	import flash.utils.ByteArray;
	
	public class TagJPEGTables extends Tag implements ITag
	{
		public static const TYPE:uint = 8;
		
		protected var _jpegTables:ByteArray;
		
		public function TagJPEGTables() {
			_jpegTables = new ByteArray();
		}
		
		public function get jpegTables():ByteArray { return _jpegTables; }
		
		public function parse(data:ISWFDataInput, length:uint):void {
			data.readBytes(_jpegTables, 0, length)
		}
		
		public function toString(indent:uint = 0):String {
			return StringUtils.repeat(indent) + "[" + StringUtils.printf("%02d", TYPE) + ":TagJPEGTables]";
		}
	}
}
