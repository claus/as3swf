package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.consts.BitmapFormat;

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
		
		public function parse(data:SWFData, length:uint, version:uint):void {
			characterId = data.readUI16();
			bitmapFormat = data.readUI8();
			bitmapWidth = data.readUI16();
			bitmapHeight = data.readUI16();
			if (bitmapFormat == BitmapFormat.BIT_8) {
				bitmapColorTableSize = data.readUI8();
			}
			data.readBytes(zlibBitmapData, 0, length - ((bitmapFormat == BitmapFormat.BIT_8) ? 8 : 7));
		}
		
		public function publish(data:SWFData, version:uint):void {
			var body:SWFData = new SWFData();
			body.writeUI16(characterId);
			body.writeUI8(bitmapFormat);
			body.writeUI16(bitmapWidth);
			body.writeUI16(bitmapHeight);
			if (bitmapFormat == BitmapFormat.BIT_8) {
				body.writeUI8(bitmapColorTableSize);
			}
			if (_zlibBitmapData.length > 0) {
				body.writeBytes(_zlibBitmapData);
			}
			data.writeTagHeader(type, body.length);
			data.writeBytes(body);
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "DefineBitsLossless"; }
		override public function get version():uint { return 2; }
		
		public function toString(indent:uint = 0):String {
			return toStringMain(indent) +
				"ID: " + characterId + ", " +
				"Format: " + BitmapFormat.toString(bitmapFormat) + ", " +
				"Size: (" + bitmapWidth + "," + bitmapHeight + ")";
		}
	}
}
