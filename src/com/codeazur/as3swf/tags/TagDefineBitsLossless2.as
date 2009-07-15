package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.ISWFDataInput;
	import com.codeazur.utils.StringUtils;
	
	public class TagDefineBitsLossless2 extends TagDefineBitsLossless implements ITag
	{
		public static const TYPE:uint = 36;
		
		public function TagDefineBitsLossless2() {}
		
		override public function toString(indent:uint = 0):String {
			return StringUtils.repeat(indent) + "[" + StringUtils.printf("%02d", TYPE) + ":TagDefineBitsLossless2] " +
				"ID: " + characterId + ", " +
				"Format: " + bitmapFormat + ", " +
				"Size: (" + bitmapWidth + "," + bitmapHeight + ")";
		}
	}
}
