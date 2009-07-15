package com.codeazur.as3swf.actions.swf3
{
	import com.codeazur.as3swf.actions.*;
	import com.codeazur.as3swf.ISWFDataInput;
	
	public class ActionNextFrame extends Action implements IAction
	{
		public function ActionNextFrame(code:uint, length:uint) {
			super(code, length);
		}
		
		public function toString(indent:uint = 0):String {
			return "[ActionNextFrame]";
		}
	}
}
