package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.ISWFDataInput;
	import com.codeazur.as3swf.data.consts.BitmapFormat;
	import com.codeazur.utils.StringUtils;

	import flash.utils.ByteArray;
	
	public class TagDefineBitsLossless extends Tag implements ITag
	{
		public static const TYPE:uint = 20;
		
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
			if (bitmapFormat == BitmapFormat.BIT_8) {
				bitmapColorTableSize = data.readUI8();
			}
			data.readBytes(zlibBitmapData, 0, length - ((bitmapFormat == BitmapFormat.BIT_8) ? 8 : 7))
		}
		
		public function toString(indent:uint = 0):String {
			return StringUtils.repeat(indent) + "[" + StringUtils.printf("%02d", TYPE) + ":TagDefineBitsLossless] " +
				"ID: " + characterId + ", " +
				"Format: " + BitmapFormat.toString(bitmapFormat) + ", " +
				"Size: (" + bitmapWidth + "," + bitmapHeight + ")";
		}
	}
}
