package com.codeazur.as3swf.data.actions.swf7
{
	import com.codeazur.as3swf.data.actions.*;
	
	public class ActionThrow extends Action implements IAction
	{
		public static const CODE:uint = 0x2a;
		
		public function ActionThrow(code:uint, length:uint) {
			super(code, length);
		}
		
		override public function toString(indent:uint = 0):String {
			return "[ActionThrow]";
		}
	}
}
