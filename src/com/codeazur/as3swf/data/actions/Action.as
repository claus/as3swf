package com.codeazur.as3swf.data.actions
{
	import com.codeazur.as3swf.SWFData;
	
	public class Action implements IAction
	{
		protected var _code:uint;
		protected var _length:uint;
		
		public function Action(code:uint, length:uint) {
			_code = code;
			_length = length;
		}

		public function get code():uint { return _code; }
		public function get length():uint { return _length; }
		
		public function parse(data:SWFData):void {
			// Do nothing. Many Actions don't have a payload. 
			// For the ones that have one we override this method.
		}
		
		public function publish(data:SWFData):void {
			write(data);
		}
		
		public function clone():IAction {
			return new Action(code, length);
		}
		
		protected function write(data:SWFData, body:SWFData = null):void {
			data.writeUI8(code);
			if (code >= 0x80) {
				if (body != null && body.length > 0) {
					_length = body.length;
					data.writeUI16(_length);
					data.writeBytes(body);
				} else {
					_length = 0;
					throw(new Error("Action body null or empty."));
				}
			} else {
				_length = 0;
			}
		}
		
		public function toString(indent:uint = 0):String {
			return "[Action] Code: " + _code.toString(16) + ", Length: " + _length;
		}
	}
}
