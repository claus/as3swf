package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.ISWFDataInput;
	import com.codeazur.utils.StringUtils;
	
	public class TagDefineFont3 extends TagDefineFont2 implements ITag
	{
		public static const TYPE:uint = 75;
		
		public function TagDefineFont3() {}
		
		override public function toString(indent:uint = 0):String {
			var str:String = StringUtils.repeat(indent) + "[" + StringUtils.printf("%02d", TYPE) + ":TagDefineFont3] " +
				"ID: " + fontId + ", " +
				"FontName: " + fontName + ", " +
				"Italic: " + italic + ", " +
				"Bold: " + bold + ", " +
				"Glyphs: " + _glyphShapeTable.length;
			for (var i:uint = 0; i < _glyphShapeTable.length; i++) {
				str += "\n" + StringUtils.repeat(indent + 2) + "[" + i + "] GlyphShapes:";
				str += _glyphShapeTable[i].toString(indent + 4);
			}
			return str;
		}
	}
}
