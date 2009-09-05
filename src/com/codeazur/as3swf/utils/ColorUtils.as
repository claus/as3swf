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
	}
}
