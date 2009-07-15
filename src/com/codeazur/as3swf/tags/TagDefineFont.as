package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.data.SWFShape;
	import com.codeazur.as3swf.ISWFDataInput;
	import com.codeazur.utils.StringUtils;
	
	public class TagDefineFont extends Tag implements ITag
	{
		public static const TYPE:uint = 10;
		
		protected var fontId:uint;
		
		protected var _glyphShapeTable:Vector.<SWFShape>;
		
		public function TagDefineFont() {
			_glyphShapeTable = new Vector.<SWFShape>();
		}
		
		public function get glyphShapeTable():Vector.<SWFShape> { return _glyphShapeTable; }
		
		public function parse(data:ISWFDataInput, length:uint):void
		{
			fontId = data.readUI16();
			
			// Because the GlyphShapeTable immediately follows the OffsetTable,
			// the number of entries in each table (the number of glyphs in the font) can be inferred by
			// dividing the first entry in the OffsetTable by two.
			var numGlyphs:uint = data.readUI16() >> 1;

			// Skip offsets. We don't need them.
			data.skipBytes((numGlyphs - 1) << 1);
			
			for (var i:uint = 0; i < numGlyphs; i++) {
				_glyphShapeTable.push(data.readSHAPE());
			}
		}
		
		public function toString(indent:uint = 0):String {
			return StringUtils.repeat(indent) + "[" + StringUtils.printf("%02d", TYPE) + ":TagDefineFont] " +
				"ID: " + fontId + ", " +
				"Glyphs: " + _glyphShapeTable.length;
		}
	}
}
