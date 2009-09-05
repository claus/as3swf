package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.utils.StringUtils;
	
	import flash.utils.ByteArray;
	
	public class TagDebugID extends Tag implements ITag
	{
		public static const TYPE:uint = 63;
		
		protected var _uuid:ByteArray;
		
		public function TagDebugID() {
			_uuid = new ByteArray();
		}
		
		public function get uuid():ByteArray { return _uuid; }
		
		public function parse(data:SWFData, length:uint, version:uint):void {
			data.readBytes(_uuid, 0, length);
		}
		
		public function publish(data:SWFData, version:uint):void {
			data.writeTagHeader(type, _uuid.length);
			data.writeBytes(_uuid);
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "DebugID"; }
		override public function get version():uint { return 6; }
		
		public function toString(indent:uint = 0):String {
			var str:String = toStringMain(indent) + "UUID: ";
			if (_uuid.length == 16) {
				str += StringUtils.printf("%02x%02x%02x%02x-", _uuid[0], _uuid[1], _uuid[2], _uuid[3]);
				str += StringUtils.printf("%02x%02x-", _uuid[4], _uuid[5]);
				str += StringUtils.printf("%02x%02x-", _uuid[6], _uuid[7]);
				str += StringUtils.printf("%02x%02x-", _uuid[8], _uuid[9]);
				str += StringUtils.printf("%02x%02x%02x%02x%02x%02x", _uuid[10], _uuid[11], _uuid[12], _uuid[13], _uuid[14], _uuid[15]);
			} else {
				str += "(invalid length: " + _uuid.length + ")";
			}
			return str;
		}
	}
}
