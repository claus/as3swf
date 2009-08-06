package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	
	public class TagFrameLabel extends Tag implements ITag
	{
		public static const TYPE:uint = 43;
		
		public var frameName:String;
		
		public function TagFrameLabel() {}
		
		public function parse(data:SWFData, length:uint):void {
			frameName = data.readString();
		}
		
		public function publish(data:SWFData):void {
			throw(new Error("TODO: implement publish()"));
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "FrameLabel"; }
		
		public function toString(indent:uint = 0):String {
			return toStringMain(indent) +
				"Name: " + frameName;
		}
	}
}
