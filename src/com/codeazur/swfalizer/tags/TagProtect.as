package com.codeazur.swfalizer.tags
{
	import com.codeazur.swfalizer.ISWFDataInput;
	import com.codeazur.utils.StringUtils;
	
	import flash.utils.ByteArray;
	
	public class TagProtect extends Tag implements ITag
	{
		public static const TYPE:uint = 24;
		
		protected var _password:ByteArray;
		
		public function TagProtect() {
			_password = new ByteArray();
		}
		
		public function get password():ByteArray { return _password; }
		
		public function parse(data:ISWFDataInput, length:uint):void {
			if (length > 0) {
				data.readBytes(_password, 0, length);
			}
		}
		
		public function toString(indent:uint = 0):String {
			return StringUtils.repeat(indent) + "[" + StringUtils.printf("%02d", TYPE) + ":TagProtect]";
		}
	}
}
