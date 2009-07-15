package com.codeazur.as3swf.data
{
	// TODO: rename to SWFActionPushValue?
	public class SWFActionValue
	{
		public static const TYPE_STRING:uint = 0;
		public static const TYPE_FLOAT:uint = 1;
		public static const TYPE_NULL:uint = 2;
		public static const TYPE_UNDEFINED:uint = 3;
		public static const TYPE_REGISTER:uint = 4;
		public static const TYPE_BOOLEAN:uint = 5;
		public static const TYPE_DOUBLE:uint = 6;
		public static const TYPE_INTEGER:uint = 7;
		public static const TYPE_CONSTANT_8:uint = 8;
		public static const TYPE_CONSTANT_16:uint = 9;

		public var type:uint;
		
		public var string:String;
		public var number:Number;
		public var register:uint;
		public var boolean:Boolean;
		public var integer:uint;
		public var constant:uint;

		public function SWFActionValue(type:uint)
		{
			this.type = type;
		}
		
		public function toString():String {
			var str:String;
			switch (type) {
				case TYPE_STRING: str = "String: " + string; break;
				case TYPE_FLOAT: str = "Float: " + number; break;
				case TYPE_NULL: str = "Null"; break;
				case TYPE_UNDEFINED: str = "Undefined"; break;
				case TYPE_REGISTER: str = "Register: " + register; break;
				case TYPE_BOOLEAN: str = "Boolean: " + boolean; break;
				case TYPE_DOUBLE: str = "Double: " + number; break;
				case TYPE_INTEGER: str = "Integer: " + integer; break;
				case TYPE_CONSTANT_8:
				case TYPE_CONSTANT_16: 
					str = "Constant: " + constant;
					break;
				default: str = ""; break;
			}
			return str;
		}
	}
}
