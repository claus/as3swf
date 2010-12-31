package com.codeazur.as3swf.data.actions.swf5
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.actions.*;
	
	public class ActionStoreRegister extends Action implements IAction
	{
		public static const CODE:uint = 0x87;
		
		public var registerNumber:uint;
		
		public function ActionStoreRegister(code:uint, length:uint) {
			super(code, length);
		}
		
		override public function parse(data:SWFData):void {
			registerNumber = data.readUI8();
		}
		
		override public function publish(data:SWFData):void {
			var body:SWFData = new SWFData();
			body.writeUI8(registerNumber);
			write(data, body);
		}
		
		override public function clone():IAction {
			var action:ActionStoreRegister = new ActionStoreRegister(code, length);
			action.registerNumber = registerNumber;
			return action;
		}
		
		override public function toString(indent:uint = 0):String {
			return "[ActionStoreRegister] RegisterNumber: " + registerNumber;
		}
	}
}
