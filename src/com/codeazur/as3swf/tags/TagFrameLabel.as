package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	
	public class TagFrameLabel extends Tag implements ITag
	{
		public static const TYPE:uint = 43;
		
		public var frameName:String;
		
		public function TagFrameLabel() {}
		
		public function parse(data:SWFData, length:uint, version:uint):void {
			frameName = data.readString();
		}
		
		public function publish(data:SWFData, version:uint):void {
			var body:SWFData = new SWFData();
			body.writeString(frameName);
			data.writeTagHeader(type, body.length);
			data.writeBytes(body);
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "FrameLabel"; }
		override public function get version():uint { return 3; }
		
		public function toString(indent:uint = 0):String {
			return toStringMain(indent) +
				"Name: " + frameName;
		}
	}
}
