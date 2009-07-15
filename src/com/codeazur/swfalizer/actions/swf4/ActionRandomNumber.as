package com.codeazur.swfalizer.actions.swf4
{
	import com.codeazur.swfalizer.actions.*;
	
	public class ActionRandomNumber extends Action implements IAction
	{
		public function ActionRandomNumber(code:uint, length:uint) {
			super(code, length);
		}
		
		public function toString(indent:uint = 0):String {
			return "[ActionRandomNumber]";
		}
	}
}
