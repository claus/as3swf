package com.codeazur.as3swf.data.actions.swf5
{
	import com.codeazur.as3swf.data.actions.*;
	
	public class ActionDecrement extends Action implements IAction
	{
		public static const CODE:uint = 0x51;
		
		public function ActionDecrement(code:uint, length:uint) {
			super(code, length);
		}
		
		override public function toString(indent:uint = 0):String {
			return "[ActionDecrement]";
		}
	}
}
