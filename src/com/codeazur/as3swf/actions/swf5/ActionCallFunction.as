﻿package com.codeazur.as3swf.actions.swf5
{
	import com.codeazur.as3swf.actions.*;
	
	public class ActionCallFunction extends Action implements IAction
	{
		public function ActionCallFunction(code:uint, length:uint) {
			super(code, length);
		}
		
		public function toString(indent:uint = 0):String {
			return "[ActionCallFunction]";
		}
	}
}
