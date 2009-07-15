package com.codeazur.swfalizer.tags
{
	import com.codeazur.swfalizer.ISWFDataInput;
	import com.codeazur.utils.StringUtils;
	
	import flash.utils.ByteArray;
	
	public class TagDoABC extends Tag implements ITag
	{
		public static const TYPE:uint = 82;
		
		public var lazyInitializeFlag:Boolean;
		public var name:String;
		
		protected var _bytes:ByteArray;
		
		public function TagDoABC() {
			_bytes = new ByteArray();
		}
		
		public function get bytes():ByteArray { return _bytes; }

		public function parse(data:ISWFDataInput, length:uint):void {
			var pos:uint = data.position;
			var flags:uint = data.readUI32();
			lazyInitializeFlag = ((flags & 0x01) != 0);
			name = data.readString();
			data.readBytes(bytes, 0, length - (data.position - pos));
		}
		
		public function toString(indent:uint = 0):String {
			return StringUtils.repeat(indent) + "[" + StringUtils.printf("%02d", TYPE) + ":TagDoABC] " +
				"Lazy: " + lazyInitializeFlag + ", " +
				((name.length > 0) ? "Name: " + name + ", " : "") +
				"Length: " + _bytes.length;
		}
	}
}
