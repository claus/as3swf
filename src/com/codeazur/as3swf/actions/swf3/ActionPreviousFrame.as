package com.codeazur.as3swf.actions.swf3
{
	import com.codeazur.as3swf.actions.*;
	
	public class ActionPreviousFrame extends Action implements IAction
	{
		public function ActionPreviousFrame(code:uint, length:uint) {
			super(code, length);
		}
		
		public function toString(indent:uint = 0):String {
			return "[ActionPreviousFrame]";
		}
	}
}
