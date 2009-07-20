package com.codeazur.as3swf.data
{
	import com.codeazur.as3swf.ISWFDataInput;
	
	public class SWFRegisterParam
	{
		public var register:uint;
		public var name:String;
		
		public function SWFRegisterParam(data:ISWFDataInput = null) {
			if (data != null) {
				parse(data);
			}
		}

		public function parse(data:ISWFDataInput):void {
			register = data.readUI8();
			name = data.readString();
		}
		
		public function toString():String {
			return register + ":" + name;
		}
	}
}
