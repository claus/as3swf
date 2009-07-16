package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.ISWFDataInput;
	import com.codeazur.utils.StringUtils;
	import flash.utils.ByteArray;
	
	public class TagDefineBitsJPEG3 extends TagDefineBitsJPEG2 implements ITag
	{
		public static const TYPE:uint = 35;
		
		protected var _bitmapAlphaData:ByteArray;
		
		public function TagDefineBitsJPEG3() {
			_bitmapAlphaData = new ByteArray();
		}
		
		public function get bitmapAlphaData():ByteArray { return _bitmapAlphaData; }
		
		override public function parse(data:ISWFDataInput, length:uint):void {
			characterId = data.readUI16();
			var alphaDataOffset:uint = data.readUI32();
			data.readBytes(_bitmapData, 0, alphaDataOffset);
			if (bitmapData[0] == 0xff && (bitmapData[1] == 0xd8 || bitmapData[1] == 0xd9)) {
				bitmapType = TagDefineBitsJPEG2.DATATYPE_JPEG;
			} else if (bitmapData[0] == 0x89 && bitmapData[1] == 0x50 && bitmapData[2] == 0x4e && bitmapData[3] == 0x47 && bitmapData[4] == 0x0d && bitmapData[5] == 0x0a && bitmapData[6] == 0x1a && bitmapData[7] == 0x0a) {
				bitmapType = TagDefineBitsJPEG2.DATATYPE_PNG;
			} else if (bitmapData[0] == 0x47 && bitmapData[1] == 0x49 && bitmapData[2] == 0x46 && bitmapData[3] == 0x38 && bitmapData[4] == 0x39 && bitmapData[5] == 0x61) {
				bitmapType = TagDefineBitsJPEG2.DATATYPE_GIF89A;
			}
			var alphaDataSize:uint = length - alphaDataOffset - 6;
			if (alphaDataSize > 0) {
				data.readBytes(_bitmapAlphaData, 0, alphaDataSize);
			}
		}
		
		override public function toString(indent:uint = 0):String {
			var str:String = StringUtils.repeat(indent) + "[" + StringUtils.printf("%02d", TYPE) + ":TagDefineBitsJPEG3] " +
				"ID: " + characterId + ", Type: ";
			switch(bitmapType) {
				case DATATYPE_JPEG: str += "JPEG"; break;
				case DATATYPE_GIF89A: str += "GIF89a"; break;
				case DATATYPE_PNG: str += "PNG"; break;
				default: str += "Unknown"; break;
			}
			str += ", HasAlphaData: " + (_bitmapAlphaData.length > 0);
			return str;
		}
	}
}
