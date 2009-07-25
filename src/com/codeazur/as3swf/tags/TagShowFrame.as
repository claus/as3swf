package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	
	public class TagShowFrame extends Tag implements ITag
	{
		public static const TYPE:uint = 1;
		
		public function TagShowFrame() {}
		
		public function parse(data:SWFData, length:uint):void {
			// Do nothing. The End tag has no body.
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "ShowFrame"; }
		
		public function toString(indent:uint = 0):String {
			return toStringMain(indent);
		}
	}
}
