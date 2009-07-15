package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.ISWFDataInput;
	import com.codeazur.as3swf.data.SWFRecordHeader;
	import com.codeazur.utils.StringUtils;
	
	import flash.utils.ByteArray;
	
	public class TagDefineFontInfo extends Tag implements ITag
	{
		public static const TYPE:uint = 13;
		
		public var fontId:uint;
		public var fontName:String;
		public var smallText:Boolean;
		public var shiftJIS:Boolean;
		public var ansi:Boolean;
		public var italic:Boolean;
		public var bold:Boolean;
		public var wideCodes:Boolean;
		
		protected var _codeTable:Vector.<uint>;
		
		public function TagDefineFontInfo() {
			_codeTable = new Vector.<uint>();
		}
		
		public function get codeTable():Vector.<uint> { return _codeTable; }
		
		public function parse(data:ISWFDataInput, length:uint):void
		{
			fontId = data.readUI16();

			var fontNameLen:uint = data.readUI8();
			var fontNameRaw:ByteArray = new ByteArray();
			data.readBytes(fontNameRaw, 0, fontNameLen);
			fontName = fontNameRaw.readUTFBytes(fontNameLen);
			
			var flags:uint = data.readUI8();
			smallText = ((flags & 0x20) == 1);
			shiftJIS = ((flags & 0x10) == 1);
			ansi = ((flags & 0x08) == 1);
			italic = ((flags & 0x04) == 1);
			bold = ((flags & 0x02) == 1);
			wideCodes = ((flags & 0x01) == 1);
			
			var numGlyphs:uint = length - fontNameLen - 4;
			for (var i:uint = 0; i < numGlyphs; i++) {
				_codeTable.push(wideCodes ? data.readUI16() : data.readUI8());
			}
		}
		
		public function toString(indent:uint = 0):String {
			return StringUtils.repeat(indent) + "[" + StringUtils.printf("%02d", TYPE) + ":TagDefineFontInfo] " +
				"FontID: " + fontId + ", " +
				"FontName: " + fontName + ", " +
				"Italic: " + italic + ", " +
				"Bold: " + bold + ", " +
				"Codes: " + _codeTable.length;
		}
	}
}
