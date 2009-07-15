package com.codeazur.swfalizer.actions.swf3
{
	import com.codeazur.swfalizer.actions.*;
	import com.codeazur.swfalizer.ISWFDataInput;
	
	public class ActionGotoFrame extends Action implements IAction
	{
		public var frame:uint;
		
		public function ActionGotoFrame(code:uint, length:uint) {
			super(code, length);
		}
		
		override public function parse(data:ISWFDataInput):void {
			frame = data.readUI16();
		}
		
		public function toString(indent:uint = 0):String {
			return "[ActionGotoFrame] Frame: " + frame;
		}
	}
}
