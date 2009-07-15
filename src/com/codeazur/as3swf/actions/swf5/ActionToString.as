package com.codeazur.as3swf.actions.swf5
{
	import com.codeazur.as3swf.actions.*;
	
	public class ActionToString extends Action implements IAction
	{
		public function ActionToString(code:uint, length:uint) {
			super(code, length);
		}
		
		public function toString(indent:uint = 0):String {
			return "[ActionToString]";
		}
	}
}
