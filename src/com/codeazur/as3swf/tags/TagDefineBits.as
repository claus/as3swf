package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.ISWFDataInput;
	import com.codeazur.utils.StringUtils;
	
	import flash.utils.ByteArray;
	
	public class TagDefineBits extends Tag implements ITag
	{
		public static const TYPE:uint = 6;
		
		public var characterId:uint;

		protected var _bitmapData:ByteArray;
		
		public function TagDefineBits() {
			_bitmapData = new ByteArray();
		}
		
		public function get bitmapData():ByteArray { return _bitmapData; }
		
		public function parse(data:ISWFDataInput, length:uint):void {
			characterId = data.readUI16();
			data.readBytes(_bitmapData, 0, length - 2)
		}
		
		public function toString(indent:uint = 0):String {
			return StringUtils.repeat(indent) + "[" + StringUtils.printf("%02d", TYPE) + ":TagDefineBits] " +
				"ID: " + characterId;
		}
	}
}
