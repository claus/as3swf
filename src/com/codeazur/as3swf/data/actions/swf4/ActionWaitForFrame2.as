package com.codeazur.as3swf.data.actions.swf4
{
	import com.codeazur.as3swf.data.actions.*;
	import com.codeazur.as3swf.SWFData;
	
	public class ActionWaitForFrame2 extends Action implements IAction
	{
		public var skipCount:uint;
		
		public function ActionWaitForFrame2(code:uint, length:uint) {
			super(code, length);
		}
		
		override public function parse(data:SWFData):void {
			skipCount = data.readUI8();
		}
		
		override public function publish(data:SWFData):void {
			var body:SWFData = new SWFData();
			body.writeUI8(skipCount);
			write(data, body);
		}
		
		public function toString(indent:uint = 0):String {
			return "[ActionWaitForFrame2] SkipCount: " + skipCount;
		}
	}
}
