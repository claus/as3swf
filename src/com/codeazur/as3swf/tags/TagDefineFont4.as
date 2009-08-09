package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	
	import flash.utils.ByteArray;
	
	public class TagDefineFont4 extends Tag implements ITag
	{
		public static const TYPE:uint = 91;
		
		public var fontId:uint;
		public var hasFontData:Boolean;
		public var italic:Boolean;
		public var bold:Boolean;
		public var fontName:String;

		protected var _fontData:ByteArray;
		
		public function TagDefineFont4() {
			_fontData = new ByteArray();
		}
		
		public function get fontData():ByteArray { return _fontData; }
		
		public function parse(data:SWFData, length:uint, version:uint):void {
			var pos:uint = data.position;
			fontId = data.readUI16();
			var flags:uint = data.readUI8();
			hasFontData = ((flags & 0x04) != 0);
			italic = ((flags & 0x02) != 0);
			bold = ((flags & 0x01) != 0);
			fontName = data.readString();
			if (hasFontData && length > data.position - pos) {
				data.readBytes(_fontData, 0, length - (data.position - pos));
			}
		}
		
		public function publish(data:SWFData, version:uint):void {
			throw(new Error("TODO: implement publish()"));
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "DefineFont4"; }
		override public function get version():uint { return 10; }
		
		public function toString(indent:uint = 0):String {
			var str:String = toStringMain(indent) +
				"ID: " + fontId + ", " +
				"FontName: " + fontName + ", " +
				"HasFontData: " + hasFontData + ", " +
				"Italic: " + italic + ", " +
				"Bold: " + bold;
			return str;
		}
	}
}
