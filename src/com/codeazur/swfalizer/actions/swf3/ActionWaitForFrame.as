package com.codeazur.swfalizer.actions.swf3
{
	import com.codeazur.swfalizer.actions.*;
	import com.codeazur.swfalizer.ISWFDataInput;
	
	public class ActionWaitForFrame extends Action implements IAction
	{
		public var frame:uint;
		public var skipCount:uint;
		
		public function ActionWaitForFrame(code:uint, length:uint) {
			super(code, length);
		}
		
		override public function parse(data:ISWFDataInput):void {
			frame = data.readUI16();
			skipCount = data.readUI8();
		}
		
		public function toString(indent:uint = 0):String {
			return "[ActionWaitForFrame] Frame: " + frame + ", SkipCount: " + skipCount;
		}
	}
}
