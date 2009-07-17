package com.codeazur.as3swf.data.consts
{
	public class BitmapFormat
	{
		public static const BIT_8:uint = 3;
		public static const BIT_15:uint = 4;
		public static const BIT_24:uint = 5;
		
		public static function toString(bitmapFormat:uint):String {
			switch(bitmapFormat) {
				case BIT_8: return "8bit"; break;
				case BIT_15: return "15bit"; break;
				case BIT_24: return "24bit"; break;
				default: return "unknown"; break;
			}
		}
	}
}
