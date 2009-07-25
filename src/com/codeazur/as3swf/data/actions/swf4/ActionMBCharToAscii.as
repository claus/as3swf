package com.codeazur.as3swf.data.actions.swf4
{
	import com.codeazur.as3swf.data.actions.*;
	
	public class ActionMBCharToAscii extends Action implements IAction
	{
		public function ActionMBCharToAscii(code:uint, length:uint) {
			super(code, length);
		}
		
		public function toString(indent:uint = 0):String {
			return "[ActionMBCharToAscii]";
		}
	}
}
