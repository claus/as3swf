package com.codeazur.swfalizer.tags
{
	import com.codeazur.swfalizer.ISWFDataInput;
	import com.codeazur.utils.StringUtils;

	import flash.utils.ByteArray;
	
	public class TagDefineBitsLossless extends Tag implements ITag
	{
		public static const TYPE:uint = 20;
		
		public static const BITMAPFORMAT_8BIT:uint = 3;
		public static const BITMAPFORMAT_15BIT:uint = 4;
		public static const BITMAPFORMAT_24BIT:uint = 5;
		
		public var characterId:uint;
		public var bitmapFormat:uint;
		public var bitmapWidth:uint;
		public var bitmapHeight:uint;
		public var bitmapColorTableSize:uint;
		
		protected var _zlibBitmapData:ByteArray;
		
		public function TagDefineBitsLossless() {
			_zlibBitmapData = new ByteArray();
		}
		
		public function get zlibBitmapData():ByteArray { return _zlibBitmapData; }
		
		public function parse(data:ISWFDataInput, length:uint):void {
			characterId = data.readUI16();
			bitmapFormat = data.readUI8();
			bitmapWidth = data.readUI16();
			bitmapHeight = data.readUI16();
			if (bitmapFormat == BITMAPFORMAT_8BIT) {
				bitmapColorTableSize = data.readUI8();
			}
			data.readBytes(zlibBitmapData, 0, length - ((bitmapFormat == BITMAPFORMAT_8BIT) ? 8 : 7))
		}
		
		public function toString(indent:uint = 0):String {
			return StringUtils.repeat(indent) + "[" + StringUtils.printf("%02d", TYPE) + ":TagDefineBitsLossless] " +
				"ID: " + characterId + ", " +
				"Format: " + bitmapFormat + ", " +
				"Size: (" + bitmapWidth + "," + bitmapHeight + ")";
		}
	}
}
