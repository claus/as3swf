package com.codeazur.as3swf.data.actions.swf5
{
	import com.codeazur.as3swf.data.actions.*;
	
	public class ActionStackSwap extends Action implements IAction
	{
		public static const CODE:uint = 0x4d;
		
		public function ActionStackSwap(code:uint, length:uint) {
			super(code, length);
		}
		
		override public function toString(indent:uint = 0):String {
			return "[ActionStackSwap]";
		}
	}
}
