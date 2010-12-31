package com.codeazur.as3swf.data.actions.swf5
{
	import com.codeazur.as3swf.data.actions.*;
	
	public class ActionIncrement extends Action implements IAction
	{
		public static const CODE:uint = 0x50;
		
		public function ActionIncrement(code:uint, length:uint) {
			super(code, length);
		}
		
		override public function toString(indent:uint = 0):String {
			return "[ActionIncrement]";
		}
	}
}
