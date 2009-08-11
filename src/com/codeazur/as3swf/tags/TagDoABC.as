package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	
	import flash.utils.ByteArray;
	
	public class TagDoABC extends Tag implements ITag
	{
		public static const TYPE:uint = 82;
		
		public var lazyInitializeFlag:Boolean;
		public var abcName:String;
		
		protected var _bytes:ByteArray;
		
		public function TagDoABC() {
			_bytes = new ByteArray();
		}
		
		public function get bytes():ByteArray { return _bytes; }

		public function parse(data:SWFData, length:uint, version:uint):void {
			var pos:uint = data.position;
			var flags:uint = data.readUI32();
			lazyInitializeFlag = ((flags & 0x01) != 0);
			abcName = data.readString();
			data.readBytes(bytes, 0, length - (data.position - pos));
		}
		
		public function publish(data:SWFData, version:uint):void {
			var body:SWFData = new SWFData();
			body.writeUI32(lazyInitializeFlag ? 1 : 0);
			body.writeString(abcName);
			if (_bytes.length > 0) {
				body.writeBytes(_bytes);
			}
			data.writeTagHeader(type, body.length);
			data.writeBytes(body);
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "DoABC"; }
		override public function get version():uint { return 9; }
		
		public function toString(indent:uint = 0):String {
			return toStringMain(indent) +
				"Lazy: " + lazyInitializeFlag + ", " +
				((abcName.length > 0) ? "Name: " + abcName + ", " : "") +
				"Length: " + _bytes.length;
		}
	}
}
