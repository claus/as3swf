package com.codeazur.as3swf.data.actions.swf4
{
	import com.codeazur.as3swf.data.actions.*;
	
	public class ActionCloneSprite extends Action implements IAction
	{
		public static const CODE:uint = 0x24;
		
		public function ActionCloneSprite(code:uint, length:uint) {
			super(code, length);
		}
		
		override public function toString(indent:uint = 0):String {
			return "[ActionCloneSprite]";
		}
	}
}
