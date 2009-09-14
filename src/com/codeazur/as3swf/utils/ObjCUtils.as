package com.codeazur.as3swf.utils
{
	public class ObjCUtils
	{
		public static function num2str(n:Number):String {
			var s:String = n.toString();
			if (s.indexOf(".") == -1) {
				s += ".0";
			}
			return s + "f";
		}
	}
}
