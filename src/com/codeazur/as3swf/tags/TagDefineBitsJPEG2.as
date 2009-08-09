package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.consts.BitmapType;
	
	public class TagDefineBitsJPEG2 extends TagDefineBits implements ITag
	{
		public static const TYPE:uint = 21;
		
		public var bitmapType:uint = BitmapType.JPEG;
		
		public function TagDefineBitsJPEG2() {}
		
		override public function parse(data:SWFData, length:uint, version:uint):void {
			super.parse(data, length, version);
			if (bitmapData[0] == 0xff && (bitmapData[1] == 0xd8 || bitmapData[1] == 0xd9)) {
				bitmapType = BitmapType.JPEG;
			} else if (bitmapData[0] == 0x89 && bitmapData[1] == 0x50 && bitmapData[2] == 0x4e && bitmapData[3] == 0x47 && bitmapData[4] == 0x0d && bitmapData[5] == 0x0a && bitmapData[6] == 0x1a && bitmapData[7] == 0x0a) {
				bitmapType = BitmapType.PNG;
			} else if (bitmapData[0] == 0x47 && bitmapData[1] == 0x49 && bitmapData[2] == 0x46 && bitmapData[3] == 0x38 && bitmapData[4] == 0x39 && bitmapData[5] == 0x61) {
				bitmapType = BitmapType.GIF89A;
			}
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "DefineBitsJPEG2"; }
		override public function get version():uint { return (bitmapType == BitmapType.JPEG) ? 2 : 8; }
		
		override public function toString(indent:uint = 0):String {
			var str:String = toStringMain(indent) +
				"ID: " + characterId + ", " +
				"Type: " + BitmapType.toString(bitmapType);
			return str;
		}
	}
}
