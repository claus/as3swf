package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.SWFKerningRecord;
	import com.codeazur.as3swf.data.SWFRectangle;
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
		
		override public function parse(data:SWFData, length:uint, version:uint):void
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
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "DefineFont2"; }
		
		override public function toString(indent:uint = 0):String {
			var str:String = toStringMain(indent) +
				"ID: " + fontId + ", " +
				"FontName: " + fontName + ", " +
				"Italic: " + italic + ", " +
				"Bold: " + bold + ", " +
				"Glyphs: " + _glyphShapeTable.length;
			return str + toStringCommon(indent);
		}
		
		override protected function toStringCommon(indent:uint):String {
			var i:uint;
			var str:String = super.toStringCommon(indent);
			if (hasLayout) {
				str += "\n" + StringUtils.repeat(indent + 2) + "Ascent: " + ascent;
				str += "\n" + StringUtils.repeat(indent + 2) + "Descent: " + descent;
				str += "\n" + StringUtils.repeat(indent + 2) + "Leading: " + leading;
			}
			if (_codeTable.length > 0) {
				str += "\n" + StringUtils.repeat(indent + 2) + "CodeTable:";
				for (i = 0; i < _codeTable.length; i++) {
					if ((i & 0x0f) == 0) {
						str += "\n" + StringUtils.repeat(indent + 4) + _codeTable[i].toString();
					} else {
						str += ", " + _codeTable[i].toString();
					}
				}
			}
			if (_fontAdvanceTable.length > 0) {
				str += "\n" + StringUtils.repeat(indent + 2) + "FontAdvanceTable:";
				for (i = 0; i < _fontAdvanceTable.length; i++) {
					if ((i & 0x07) == 0) {
						str += "\n" + StringUtils.repeat(indent + 4) + _fontAdvanceTable[i].toString();
					} else {
						str += ", " + _fontAdvanceTable[i].toString();
					}
				}
			}
			if (_fontBoundsTable.length > 0) {
				var hasNonNullBounds:Boolean = false;
				for (i = 0; i < _fontBoundsTable.length; i++) {
					var rect:SWFRectangle = _fontBoundsTable[i];
					if (rect.xmin != 0 || rect.xmax != 0 || rect.ymin != 0 || rect.ymax != 0) {
						hasNonNullBounds = true;
						break;
					}
				}
				if (hasNonNullBounds) {
					str += "\n" + StringUtils.repeat(indent + 2) + "FontBoundsTable:";
					for (i = 0; i < _fontBoundsTable.length; i++) {
						str += "\n" + StringUtils.repeat(indent + 4) + "[" + i + "] " + _fontBoundsTable[i].toString();
					}
				}
			}
			if (_fontKerningTable.length > 0) {
				str += "\n" + StringUtils.repeat(indent + 2) + "KerningTable:";
				for (i = 0; i < _fontKerningTable.length; i++) {
					str += "\n" + StringUtils.repeat(indent + 4) + "[" + i + "] " + _fontKerningTable[i].toString();
				}
			}
			return str;
		}
	}
}
