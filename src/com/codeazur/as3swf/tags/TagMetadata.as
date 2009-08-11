package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	
	public class TagMetadata extends Tag implements ITag
	{
		public static const TYPE:uint = 77;
		
		public var xmlString:String;
		
		public function TagMetadata() {}
		
		public function parse(data:SWFData, length:uint, version:uint):void {
			xmlString = data.readString();
		}
		
		public function publish(data:SWFData, version:uint):void {
			var body:SWFData = new SWFData();
			body.writeString(xmlString);
			data.writeTagHeader(type, body.length);
			data.writeBytes(body);
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "Metadata"; }
		override public function get version():uint { return 1; }
		
		public function toString(indent:uint = 0):String {
			return toStringMain(indent);
		}
	}
}
