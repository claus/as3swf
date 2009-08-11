package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	
	public class TagUnknown extends Tag implements ITag
	{
		public function TagUnknown(type:uint) {
			_type = type;
		}
		
		public function parse(data:SWFData, length:uint, version:uint):void {
			data.skipBytes(length);
		}
		
		public function publish(data:SWFData, version:uint):void {
			if (raw != null) {
				data.writeBytes(raw);
			} else {
				throw(new Error("No raw tag data available."));
			}
		}
		
		public function toString(indent:uint = 0):String {
			return toStringMain(indent) + 
				"Length: " + ((raw != null) ? raw.length : 0);
		}
	}
}
