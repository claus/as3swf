package com.codeazur.as3swf.data.actions.swf6
{
	import com.codeazur.as3swf.data.actions.*;
	
	public class ActionInstanceOf extends Action implements IAction
	{
		public function ActionInstanceOf(code:uint, length:uint) {
			super(code, length);
		}
		
		public function toString(indent:uint = 0):String {
			return "[ActionInstanceOf]";
		}
	}
}
