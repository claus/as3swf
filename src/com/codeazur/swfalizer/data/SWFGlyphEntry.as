package com.codeazur.swfalizer.data
{
	public class SWFGlyphEntry
	{
		public var index:uint;
		public var advance:int;
		
		public function SWFGlyphEntry(index:uint, advance:int)
		{
			this.index = index;
			this.advance = advance;
		}
		
		public function toString():String {
			return index.toString();
		}
	}
}
