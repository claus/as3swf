package com.codeazur.as3swf.data.consts
{
	public class LineJoinStyle
	{
		public static const ROUND:uint = 0;
		public static const BEVEL:uint = 1;
		public static const MITER:uint = 2;
		
		public static function toString(lineJoinStyle:uint):String {
			switch(lineJoinStyle) {
				case ROUND: return "round";
				case BEVEL: return "bevel";
				case MITER: return "miter";
				default: return "unknown";
			}
		}
	}
}
