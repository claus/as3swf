package com.codeazur.as3swf.data.actions.swf4
{
	import com.codeazur.as3swf.data.actions.*;
	
	public class ActionAsciiToChar extends Action implements IAction
	{
		public function ActionAsciiToChar(code:uint, length:uint) {
			super(code, length);
		}
		
		public function toString(indent:uint = 0):String {
			return "[ActionAsciiToChar]";
		}
	}
}
