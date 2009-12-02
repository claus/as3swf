package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	
	public class TagFrameLabel extends Tag implements ITag
	{
		public static const TYPE:uint = 43;
		
		public var frameName:String;
		public var namedAnchorFlag:Boolean;
		
		public function TagFrameLabel() {}
		
		public function parse(data:SWFData, length:uint, version:uint):void {
			var start:uint = data.position;
			frameName = data.readString();
			if ((data.position - start) < length) {
				data.readUI8();	// Named anchor flag, always 1
				namedAnchorFlag = true;
			}
		}
		
		public function publish(data:SWFData, version:uint):void {
			var body:SWFData = new SWFData();
			body.writeString(frameName);
			
			if (namedAnchorFlag) {
				data.writeUI8(1);
			}
			
			data.writeTagHeader(type, body.length);
			data.writeBytes(body);
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "FrameLabel"; }
		override public function get version():uint { return 3; }
		
		public function toString(indent:uint = 0):String {
			var str:String = "Name: " + frameName;
			if (namedAnchorFlag) {
				str += ", NamedAnchor = true";
			}
			return toStringMain(indent) + str;
		}
	}
}
