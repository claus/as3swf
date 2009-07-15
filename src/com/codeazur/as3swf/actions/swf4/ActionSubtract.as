package com.codeazur.as3swf.actions.swf4
{
	import com.codeazur.as3swf.actions.*;
	
	public class ActionSubtract extends Action implements IAction
	{
		public function ActionSubtract(code:uint, length:uint) {
			super(code, length);
		}
		
		public function toString(indent:uint = 0):String {
			return "[ActionSubtract]";
		}
	}
}
