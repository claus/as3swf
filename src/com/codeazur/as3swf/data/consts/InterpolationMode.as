package com.codeazur.as3swf.data.consts
{
	public class InterpolationMode
	{
		public static const NORMAL:uint = 0;
		public static const LINEAR:uint = 1;
		
		public static function toString(interpolationMode:uint):String {
			switch(interpolationMode) {
				case NORMAL: return "normal"; break;
				case LINEAR: return "linear"; break;
				default: return "unknown"; break;
			}
		}
	}
}
