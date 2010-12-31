package com.codeazur.as3swf.data.actions.swf5
{
	import com.codeazur.as3swf.data.actions.*;
	
	public class ActionEnumerate extends Action implements IAction
	{
		public static const CODE:uint = 0x46;
		
		public function ActionEnumerate(code:uint, length:uint) {
			super(code, length);
		}
		
		override public function toString(indent:uint = 0):String {
			return "[ActionEnumerate]";
		}
	}
}
