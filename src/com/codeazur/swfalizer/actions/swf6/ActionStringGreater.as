package com.codeazur.swfalizer.actions.swf6
{
	import com.codeazur.swfalizer.actions.*;
	
	public class ActionStringGreater extends Action implements IAction
	{
		public function ActionStringGreater(code:uint, length:uint) {
			super(code, length);
		}
		
		public function toString(indent:uint = 0):String {
			return "[ActionStringGreater]";
		}
	}
}
