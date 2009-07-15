package com.codeazur.swfalizer.actions.swf5
{
	import com.codeazur.swfalizer.actions.*;
	import com.codeazur.swfalizer.ISWFDataInput;
	
	public class ActionStoreRegister extends Action implements IAction
	{
		public var registerNumber:uint;
		
		public function ActionStoreRegister(code:uint, length:uint) {
			super(code, length);
		}
		
		override public function parse(data:ISWFDataInput):void {
			registerNumber = data.readUI8();
		}
		
		public function toString(indent:uint = 0):String {
			return "[ActionStoreRegister] RegisterNumber: " + registerNumber;
		}
	}
}
