package com.codeazur.as3swf.data.actions.swf5
{
	import com.codeazur.as3swf.data.actions.*;
	
	public class ActionLess2 extends Action implements IAction
	{
		public static const CODE:uint = 0x48;
		
		public function ActionLess2(code:uint, length:uint) {
			super(code, length);
		}
		
		override public function toString(indent:uint = 0):String {
			return "[ActionLess2]";
		}
	}
}
