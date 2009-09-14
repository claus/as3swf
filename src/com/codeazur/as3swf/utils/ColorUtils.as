package com.codeazur.as3swf.utils
{
	public class ColorUtils
	{
		public static function alpha(color:uint):Number {
			return Number(color >>> 24) / 255;
		}

		public static function rgb(color:uint):uint {
			return (color & 0xffffff);
		}
		
		public static function r(color:uint):Number {
			return Number((rgb(color) >> 16) & 0xff) / 255;
		}
		
		public static function g(color:uint):Number {
			return Number((rgb(color) >> 8) & 0xff) / 255;
		}
		
		public static function b(color:uint):Number {
			return Number(rgb(color) & 0xff) / 255;
		}
	}
}
