package com.codeazur.as3swf.data.actions.swf4
{
	import com.codeazur.as3swf.data.actions.*;
	
	public class ActionStringEquals extends Action implements IAction
	{
		public static const CODE:uint = 0x13;
		
		public function ActionStringEquals(code:uint, length:uint) {
			super(code, length);
		}
		
		override public function toString(indent:uint = 0):String {
			return "[ActionStringEquals]";
		}
	}
}
