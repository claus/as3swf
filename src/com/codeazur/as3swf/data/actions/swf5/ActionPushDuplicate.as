package com.codeazur.as3swf.data.actions.swf5
{
	import com.codeazur.as3swf.data.actions.*;
	
	public class ActionPushDuplicate extends Action implements IAction
	{
		public function ActionPushDuplicate(code:uint, length:uint) {
			super(code, length);
		}
		
		public function toString(indent:uint = 0):String {
			return "[ActionPushDuplicate]";
		}
	}
}
