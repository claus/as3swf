package com.codeazur.as3swf.data.actions
{
	import com.codeazur.as3swf.SWFData;
	
	public class Action
	{
		protected var _code:uint;
		protected var _length:uint;
		
		public function Action(code:uint, length:uint) {
			_code = code;
			_length = length;
		}

		public function parse(data:SWFData):void {}
	}
}
