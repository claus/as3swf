package com.codeazur.as3swf.data.actions.swf7
{
	import com.codeazur.as3swf.data.actions.*;
	
	public class ActionExtends extends Action implements IAction
	{
		public static const CODE:uint = 0x69;
		
		public function ActionExtends(code:uint, length:uint) {
			super(code, length);
		}
		
		override public function toString(indent:uint = 0):String {
			return "[ActionExtends]";
		}
	}
}
