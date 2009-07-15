package com.codeazur.as3swf.data
{
	public class SWFTextRecord
	{
		public var type:uint;
		public var hasFont:Boolean;
		public var hasColor:Boolean;
		public var hasXOffset:Boolean;
		public var hasYOffset:Boolean;
		
		public var fontId:uint;
		public var textColor:uint;
		public var textHeight:uint;
		public var xOffset:int;
		public var yOffset:int;
		
		protected var _glyphEntries:Vector.<SWFGlyphEntry>;
		
		public function SWFTextRecord(styles:uint)
		{
			this.type = styles >> 7;
			this.hasFont = ((styles & 0x08) != 0);
			this.hasColor = ((styles & 0x04) != 0);
			this.hasYOffset = ((styles & 0x02) != 0);
			this.hasXOffset = ((styles & 0x01) != 0);
			
			_glyphEntries = new Vector.<SWFGlyphEntry>();
		}
		
		public function get glyphEntries():Vector.<SWFGlyphEntry> { return _glyphEntries; }
		
		public function toString():String {
			var params:Array = ["Glyphs: " + _glyphEntries.length.toString()];
			if (hasFont) { params.push("FontID: " + fontId); params.push("Height: " + textHeight); }
			if (hasColor) { params.push("Color: " + textColor.toString(16)); }
			if (hasXOffset) { params.push("XOffset: " + xOffset); }
			if (hasYOffset) { params.push("YOffset: " + yOffset); }
			return params.join(", ");
		}
	}
}
