package com.codeazur.as3swf.data.consts
{
	public class SpreadMode
	{
		public static const PAD:uint = 0;
		public static const REFLECT:uint = 1;
		public static const REPEAT:uint = 2;
		
		public static function toString(spreadMode:uint):String {
			switch(spreadMode) {
				case PAD: return "pad"; break;
				case REFLECT: return "reflect"; break;
				case REPEAT: return "repeat"; break;
				default: return "unknown"; break;
			}
		}
	}
}
