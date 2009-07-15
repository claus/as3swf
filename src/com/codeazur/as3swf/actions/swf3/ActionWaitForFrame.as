package com.codeazur.as3swf.actions.swf3
{
	import com.codeazur.as3swf.actions.*;
	import com.codeazur.as3swf.ISWFDataInput;
	
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
