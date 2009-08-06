package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	
	public class TagSetBackgroundColor extends Tag implements ITag
	{
		public static const TYPE:uint = 9;
		
		public var color:uint;
		
		public function TagSetBackgroundColor() {}
		
		public function parse(data:SWFData, length:uint):void {
			color = data.readRGB();
		}
		
		public function publish(data:SWFData):void {
			throw(new Error("TODO: implement publish()"));
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "SetBackgroundColor"; }
		
		public function toString(indent:uint = 0):String {
			return toStringMain(indent) +
				"Color: " + color.toString(16);
		}
	}
}
