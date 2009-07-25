package com.codeazur.as3swf.data.actions.swf5
{
	import com.codeazur.as3swf.data.actions.*;
	
	public class ActionDefineLocal2 extends Action implements IAction
	{
		public function ActionDefineLocal2(code:uint, length:uint) {
			super(code, length);
		}
		
		public function toString(indent:uint = 0):String {
			return "[ActionDefineLocal2]";
		}
	}
}
