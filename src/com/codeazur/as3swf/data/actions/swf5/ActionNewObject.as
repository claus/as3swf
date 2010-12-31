package com.codeazur.as3swf.data.actions.swf5
{
	import com.codeazur.as3swf.data.actions.*;
	
	public class ActionNewObject extends Action implements IAction
	{
		public static const CODE:uint = 0x40;
		
		public function ActionNewObject(code:uint, length:uint) {
			super(code, length);
		}
		
		override public function toString(indent:uint = 0):String {
			return "[ActionNewObject]";
		}
	}
}
