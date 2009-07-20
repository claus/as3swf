package com.codeazur.as3swf.data
{
	import com.codeazur.as3swf.ISWFDataInput;
	import com.codeazur.as3swf.data.consts.ActionValueType;
	
	public class SWFActionValue
	{
		public var type:uint;
		public var string:String;
		public var number:Number;
		public var register:uint;
		public var boolean:Boolean;
		public var integer:uint;
		public var constant:uint;

		public function SWFActionValue(data:ISWFDataInput = null) {
			if (data != null) {
				parse(data);
			}
		}
		
		public function parse(data:ISWFDataInput):void {
			type = data.readUI8();
			switch (type) {
				case ActionValueType.STRING: string = data.readString(); break;
				case ActionValueType.FLOAT: number = data.readFLOAT(); break;
				case ActionValueType.NULL: break;
				case ActionValueType.UNDEFINED: break;
				case ActionValueType.REGISTER: register = data.readUI8(); break;
				case ActionValueType.BOOLEAN: boolean = (data.readUI8() != 0); break;
				case ActionValueType.DOUBLE: number = data.readDOUBLE(); break;
				case ActionValueType.INTEGER: integer = data.readUI32(); break;
				case ActionValueType.CONSTANT_8: constant = data.readUI8(); break;
				case ActionValueType.CONSTANT_16: constant = data.readUI16(); break;
				default:
					throw(new Error("Unknown ActionValueType: " + type));
			}
		}
		
		public function toString():String {
			return ActionValueType.toString(type);
		}
	}
}
