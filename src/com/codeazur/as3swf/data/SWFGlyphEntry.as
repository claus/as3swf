package com.codeazur.as3swf.data
{
	import com.codeazur.as3swf.SWFData;
	
	public class SWFGlyphEntry
	{
		public var index:uint;
		public var advance:int;
		
		public function SWFGlyphEntry(data:SWFData = null, glyphBits:uint = 0, advanceBits:uint = 0) {
			if (data != null) {
				parse(data, glyphBits, advanceBits);
			}
		}
		
		public function parse(data:SWFData, glyphBits:uint, advanceBits:uint):void {
			// GLYPHENTRYs are not byte aligned
			index = data.readUB(glyphBits);
			advance = data.readSB(advanceBits);
		}
		
		public function toString():String {
			return index.toString();
		}
	}
}
