package com.codeazur.as3swf.data
{
	public class SWFRegisterParam
	{
		public var register:uint;
		public var name:String;
		
		public function SWFRegisterParam(register:uint, name:String)
		{
			this.register = register;
			this.name = name;
		}
		
		public function toString():String {
			return register + ":" + name;
		}
	}
}
