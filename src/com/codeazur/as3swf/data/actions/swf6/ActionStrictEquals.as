package com.codeazur.as3swf.data.actions.swf6
{
	import com.codeazur.as3swf.data.actions.*;
	
	public class ActionStrictEquals extends Action implements IAction
	{
		public function ActionStrictEquals(code:uint, length:uint) {
			super(code, length);
		}
		
		public function toString(indent:uint = 0):String {
			return "[ActionStrictEquals]";
		}
	}
}
