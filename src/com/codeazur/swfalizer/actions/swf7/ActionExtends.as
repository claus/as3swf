package com.codeazur.swfalizer.actions.swf7
{
	import com.codeazur.swfalizer.actions.*;
	
	public class ActionExtends extends Action implements IAction
	{
		public function ActionExtends(code:uint, length:uint) {
			super(code, length);
		}
		
		public function toString(indent:uint = 0):String {
			return "[ActionExtends]";
		}
	}
}
