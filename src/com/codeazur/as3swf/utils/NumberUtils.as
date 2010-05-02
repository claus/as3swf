package com.codeazur.as3swf.utils
{
	public class NumberUtils
	{
		public static function roundPixels20(pixels:Number):Number {
			return Math.round(pixels * 100) / 100;
		}
	}
}
