package com.codeazur.as3swf.data.actions.swf3
{
	import com.codeazur.as3swf.data.actions.*;
	
	public class ActionPreviousFrame extends Action implements IAction
	{
		public static const CODE:uint = 0x05;
		
		public function ActionPreviousFrame(code:uint, length:uint) {
			super(code, length);
		}
		
		override public function toString(indent:uint = 0):String {
			return "[ActionPreviousFrame]";
		}
	}
}
