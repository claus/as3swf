package com.codeazur.swfalizer.actions
{
	import com.codeazur.swfalizer.ISWFDataInput;
	
	public class Action
	{
		protected var _code:uint;
		protected var _length:uint;
		
		public function Action(code:uint, length:uint) {
			_code = code;
			_length = length;
		}

		public function parse(data:ISWFDataInput):void {}
	}
}
