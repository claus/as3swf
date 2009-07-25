package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	
	public class TagUnknown extends Tag implements ITag
	{
		public function TagUnknown(type:uint) { _type = type; }
		
		public function parse(data:SWFData, length:uint):void {
			cache(data, length);
		}
		
		public function toString(indent:uint = 0):String {
			return toStringMain(indent) + 
				"Length: " + raw.length;
		}
	}
}
