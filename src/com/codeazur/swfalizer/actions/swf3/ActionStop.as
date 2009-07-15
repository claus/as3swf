package com.codeazur.swfalizer.actions.swf3
{
	import com.codeazur.swfalizer.actions.*;
	
	public class ActionStop extends Action implements IAction
	{
		public function ActionStop(code:uint, length:uint) {
			super(code, length);
		}
		
		public function toString(indent:uint = 0):String {
			return "[ActionStop]";
		}
	}
}
