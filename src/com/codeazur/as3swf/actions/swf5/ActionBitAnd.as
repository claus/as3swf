﻿package com.codeazur.as3swf.actions.swf5
{
	import com.codeazur.as3swf.actions.*;
	
	public class ActionBitAnd extends Action implements IAction
	{
		public function ActionBitAnd(code:uint, length:uint) {
			super(code, length);
		}
		
		public function toString(indent:uint = 0):String {
			return "[ActionBitAnd]";
		}
	}
}
