package com.codeazur.swfalizer.actions.swf4
{
	import com.codeazur.swfalizer.actions.*;
	import com.codeazur.swfalizer.ISWFDataInput;
	
	public class ActionWaitForFrame2 extends Action implements IAction
	{
		public var skipCount:uint;
		
		public function ActionWaitForFrame2(code:uint, length:uint) {
			super(code, length);
		}
		
		override public function parse(data:ISWFDataInput):void {
			skipCount = data.readUI8();
		}
		
		public function toString(indent:uint = 0):String {
			return "[ActionWaitForFrame2] SkipCount: " + skipCount;
		}
	}
}
