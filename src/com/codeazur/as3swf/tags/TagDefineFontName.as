package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	
	public class TagDefineFontName extends Tag implements ITag
	{
		public static const TYPE:uint = 88;
		
		public var fontId:uint;
		public var fontName:String;
		public var fontCopyright:String;
		
		public function TagDefineFontName() {}
		
		public function parse(data:SWFData, length:uint, version:uint):void {
			fontId = data.readUI16();
			fontName = data.readString();
			fontCopyright = data.readString();
		}
		
		public function publish(data:SWFData, version:uint):void {
			var body:SWFData = new SWFData();
			body.writeUI16(fontId);
			body.writeString(fontName);
			body.writeString(fontCopyright);
			data.writeTagHeader(type, body.length);
			data.writeBytes(body);
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "DefineFontName"; }
		override public function get version():uint { return 9; }
		
		public function toString(indent:uint = 0):String {
			return toStringMain(indent) +
				"FontID: " + fontId + ", " +
				"Name: " + fontName + ", " +
				"Copyright: " + fontCopyright;
		}
	}
}
