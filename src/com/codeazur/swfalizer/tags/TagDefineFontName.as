package com.codeazur.swfalizer.tags
{
	import com.codeazur.swfalizer.ISWFDataInput;
	import com.codeazur.utils.StringUtils;
	
	public class TagDefineFontName extends Tag implements ITag
	{
		public static const TYPE:uint = 88;
		
		public var fontId:uint;
		public var fontName:String;
		public var fontCopyright:String;
		
		public function TagDefineFontName() {}
		
		public function parse(data:ISWFDataInput, length:uint):void {
			fontId = data.readUI16();
			fontName = data.readString();
			fontCopyright = data.readString();
		}
		
		public function toString(indent:uint = 0):String {
			return StringUtils.repeat(indent) + "[" + StringUtils.printf("%02d", TYPE) + ":TagDefineFontName] " +
				"FontID: " + fontId + ", " +
				"Name: " + fontName + ", " +
				"Copyright: " + fontCopyright;
		}
	}
}
