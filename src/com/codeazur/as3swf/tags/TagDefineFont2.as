package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.ISWFDataInput;
	import com.codeazur.as3swf.data.SWFKerningRecord;
	import com.codeazur.as3swf.data.SWFRectangle;
	import com.codeazur.as3swf.data.SWFShape;
	import com.codeazur.utils.StringUtils;
	
	import flash.utils.ByteArray;
	
	public class TagDefineFont2 extends TagDefineFont implements ITag
	{
		public static const TYPE:uint = 48;
		
		public var hasLayout:Boolean;
		public var shiftJIS:Boolean;
		public var smallText:Boolean;
		public var ansi:Boolean;
		public var wideOffsets:Boolean;
		public var wideCodes:Boolean;
		public var italic:Boolean;
		public var bold:Boolean;
		public var languageCode:uint;
		public var fontName:String;
		public var ascent:int;
		public var descent:int;
		public var leading:int;

		protected var _codeTable:Vector.<uint>;
		protected var _fontAdvanceTable:Vector.<int>;
		protected var _fontBoundsTable:Vector.<SWFRectangle>;
		protected var _fontKerningTable:Vector.<SWFKerningRecord>;
		
		public function TagDefineFont2() {
			_codeTable = new Vector.<uint>();
			_fontAdvanceTable = new Vector.<int>();
			_fontBoundsTable = new Vector.<SWFRectangle>();
			_fontKerningTable = new Vector.<SWFKerningRecord>();
		}
		
		public function get codeTable():Vector.<uint> { return _codeTable; }
		public function get fontAdvanceTable():Vector.<int> { return _fontAdvanceTable; }
		public function get fontBoundsTable():Vector.<SWFRectangle> { return _fontBoundsTable; }
		public function get fontKerningTable():Vector.<SWFKerningRecord> { return _fontKerningTable; }
		
		override public function parse(data:ISWFDataInput, length:uint):void
		{
			fontId = data.readUI16();
			
			var flags:uint = data.readUI8();
			hasLayout = ((flags & 0x80) != 0);
			shiftJIS = ((flags & 0x40) != 0);
			smallText = ((flags & 0x20) != 0);
			ansi = ((flags & 0x10) != 0);
			wideOffsets = ((flags & 0x08) != 0);
			wideCodes = ((flags & 0x04) != 0);
			italic = ((flags & 0x02) != 0);
			bold = ((flags & 0x01) != 0);
			
			languageCode = data.readLANGCODE();
			
			var fontNameLen:uint = data.readUI8();
			var fontNameRaw:ByteArray = new ByteArray();
			data.readBytes(fontNameRaw, 0, fontNameLen);
			fontName = fontNameRaw.readUTFBytes(fontNameLen);
			
			var i:uint;
			var numGlyphs:uint = data.readUI16();

			// Skip offsets. We don't need them.
			data.skipBytes(numGlyphs << (wideOffsets ? 2 : 1));
			
			// Not used
			var codeTableOffset:uint = (wideOffsets ? data.readUI32() : data.readUI16());
			
			for (i = 0; i < numGlyphs; i++) {
				_glyphShapeTable.push(data.readSHAPE());
			}
			for (i = 0; i < numGlyphs; i++) {
				_codeTable.push(data.readUI16());
			}
			if (hasLayout) {
				ascent = data.readSI16();
				descent = data.readSI16();
				leading = data.readSI16();
				for (i = 0; i < numGlyphs; i++) {
					_fontAdvanceTable.push(data.readSI16());
				}
				for (i = 0; i < numGlyphs; i++) {
					_fontBoundsTable.push(data.readRECT());
				}
				var kerningCount:uint = data.readUI16();
				for (i = 0; i < kerningCount; i++) {
					_fontKerningTable.push(data.readKERNINGRECORD(wideCodes));
				}
			}
		}
		
		override public function toString(indent:uint = 0):String {
			return StringUtils.repeat(indent) + "[" + StringUtils.printf("%02d", TYPE) + ":TagDefineFont2] " +
				"ID: " + fontId + ", " +
				"FontName: " + fontName + ", " +
				"Italic: " + italic + ", " +
				"Bold: " + bold + ", " +
				"Glyphs: " + _glyphShapeTable.length;
		}
	}
}
