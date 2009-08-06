package com.codeazur.as3swf.tags
{
	public class TagDefineBitsLossless2 extends TagDefineBitsLossless implements ITag
	{
		public static const TYPE:uint = 36;
		
		public function TagDefineBitsLossless2() {}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "DefineBitsLossless2"; }
		override public function get version():uint { return 3; }
		
		override public function toString(indent:uint = 0):String {
			return toStringMain(indent) +
				"ID: " + characterId + ", " +
				"Format: " + bitmapFormat + ", " +
				"Size: (" + bitmapWidth + "," + bitmapHeight + ")";
		}
	}
}
