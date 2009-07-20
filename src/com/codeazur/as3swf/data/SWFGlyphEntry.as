package com.codeazur.as3swf.data
{
	import com.codeazur.as3swf.ISWFDataInput;
	
	public class SWFGlyphEntry
	{
		public var index:uint;
		public var advance:int;
		
		public function SWFGlyphEntry(data:ISWFDataInput = null, glyphBits:uint = 0, advanceBits:uint = 0) {
			if (data != null) {
				parse(data, glyphBits, advanceBits);
			}
		}
		
		public function parse(data:ISWFDataInput, glyphBits:uint, advanceBits:uint):void {
			// GLYPHENTRYs are not byte aligned
			index = data.readUB(glyphBits);
			advance = data.readSB(advanceBits);
		}
		
		public function toString():String {
			return index.toString();
		}
	}
}
