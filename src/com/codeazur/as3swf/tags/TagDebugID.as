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
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "DebugID"; }
		override public function get version():uint { return 6; }
		
		public function toString(indent:uint = 0):String {
			var str:String = toStringMain(indent) + "UUID: ";
			for (var i:uint = 0; i < _uuid.length; i++) {
				str += StringUtils.printf("%02x ", _uuid[i]);
			}
			return str;
		}
	}
}
