package com.codeazur.swfalizer.actions.swf3
{
	import com.codeazur.swfalizer.actions.*;
	import com.codeazur.swfalizer.ISWFDataInput;
	
	public class ActionPlay extends Action implements IAction
	{
		public function ActionPlay(code:uint, length:uint) {
			super(code, length);
		}
		
		public function toString(indent:uint = 0):String {
			return "[ActionPlay]";
		}
	}
}
