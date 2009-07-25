package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	
	public class TagEnd extends Tag implements ITag
	{
		public static const TYPE:uint = 0;
		
		public function TagEnd() {}
		
		public function parse(data:SWFData, length:uint):void {
			// Do nothing. The End tag has no body.
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "End"; }
		
		public function toString(indent:uint = 0):String {
			return toStringMain(indent);
		}
	}
}
