package com.codeazur.as3swf.actions.swf7
{
	import com.codeazur.as3swf.actions.*;
	
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
