package com.codeazur.as3swf.data.consts
{
	public class LineCapStyle
	{
		public static const ROUND:uint = 0;
		public static const NO:uint = 1;
		public static const SQUARE:uint = 2;
		
		public static function toString(lineCapStyle:uint):String {
			switch(lineCapStyle) {
				case ROUND: return "round";
				case NO: return "no";
				case SQUARE: return "square";
				default: return "unknown";
			}
		}
	}
}
