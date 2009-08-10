package com.codeazur.as3swf.data.actions.swf5
{
	import com.codeazur.as3swf.data.actions.*;
	import com.codeazur.as3swf.SWFData;
	
	public class ActionStoreRegister extends Action implements IAction
	{
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
		
		public function toString(indent:uint = 0):String {
			return "[ActionStoreRegister] RegisterNumber: " + registerNumber;
		}
	}
}
