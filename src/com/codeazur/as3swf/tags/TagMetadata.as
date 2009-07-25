package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	
	public class TagMetadata extends Tag implements ITag
	{
		public static const TYPE:uint = 77;
		
		public var xmlString:String;
		
		public function TagMetadata() {}
		
		public function parse(data:SWFData, length:uint):void {
			cache(data, length);
			xmlString = data.readString();
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "Metadata"; }
		
		public function toString(indent:uint = 0):String {
			return toStringMain(indent);
		}
	}
}
