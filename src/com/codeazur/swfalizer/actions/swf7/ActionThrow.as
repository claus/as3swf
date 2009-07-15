package com.codeazur.swfalizer.actions.swf7
{
	import com.codeazur.swfalizer.actions.*;
	
	public class ActionThrow extends Action implements IAction
	{
		public function ActionThrow(code:uint, length:uint) {
			super(code, length);
		}
		
		public function toString(indent:uint = 0):String {
			return "[ActionThrow]";
		}
	}
}
