package com.codeazur.swfalizer.actions
{
	import com.codeazur.swfalizer.ISWFDataInput;
	
	public class ActionUnknown extends Action implements IAction
	{
		public function ActionUnknown(code:uint, length:uint) {
			super(code, length);
		}
		
		override public function parse(data:ISWFDataInput):void {
			if (_length > 0) {
				data.skipBytes(_length);
			}
		}
		
		public function toString(indent:uint = 0):String {
			return "[????] Code: " + _code.toString(16) + ", Length: " + _length;
		}
	}
}
