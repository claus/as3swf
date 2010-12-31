package com.codeazur.as3swf.data
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.consts.ActionValueType;
	import com.codeazur.utils.StringUtils;
	
	public class SWFActionValue
	{
		public var type:uint;
		public var string:String;
		public var number:Number;
		public var register:uint;
		public var boolean:Boolean;
		public var integer:uint;
		public var constant:uint;

		public function SWFActionValue(data:SWFData = null) {
			if (data != null) {
				parse(data);
			}
		}
		
		public function parse(data:SWFData):void {
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
		
		public function publish(data:SWFData):void {
			data.writeUI8(type);
			switch (type) {
				case ActionValueType.STRING: data.writeString(string); break;
				case ActionValueType.FLOAT: data.writeFLOAT(number); break;
				case ActionValueType.NULL: break;
				case ActionValueType.UNDEFINED: break;
				case ActionValueType.REGISTER: data.writeUI8(register); break;
				case ActionValueType.BOOLEAN: data.writeUI8(boolean ? 1 : 0); break;
				case ActionValueType.DOUBLE: data.writeDOUBLE(number); break;
				case ActionValueType.INTEGER: data.writeUI32(integer); break;
				case ActionValueType.CONSTANT_8: data.writeUI8(constant); break;
				case ActionValueType.CONSTANT_16: data.writeUI16(constant); break;
				default:
					throw(new Error("Unknown ActionValueType: " + type));
			}
		}
		
		public function clone():SWFActionValue {
			var value:SWFActionValue = new SWFActionValue();
			switch (type) {
				case ActionValueType.FLOAT:
				case ActionValueType.DOUBLE:
					value.number = number;
					break;
				case ActionValueType.CONSTANT_8:
				case ActionValueType.CONSTANT_16:
					value.constant = constant;
					break;
				case ActionValueType.NULL: break;
				case ActionValueType.UNDEFINED: break;
				case ActionValueType.STRING: value.string = string; break;
				case ActionValueType.REGISTER: value.register = register; break;
				case ActionValueType.BOOLEAN: value.boolean = boolean; break;
				case ActionValueType.INTEGER: value.integer = integer; break;
				default:
					throw(new Error("Unknown ActionValueType: " + type));
			}
			return value;
		}
		
		public function toString():String {
			var str:String = "";
			switch (type) {
				case ActionValueType.STRING: str = StringUtils.simpleEscape(string) + " (string)"; break;
				case ActionValueType.FLOAT: str = number + " (number)"; break;
				case ActionValueType.NULL: str = "null";  break;
				case ActionValueType.UNDEFINED: str = "undefined";  break;
				case ActionValueType.REGISTER: str = register + " (register)"; break;
				case ActionValueType.BOOLEAN: str = boolean + " (boolean)"; break;
				case ActionValueType.DOUBLE: str = number + " (double)"; break;
				case ActionValueType.INTEGER: str = integer + " (integer)"; break;
				case ActionValueType.CONSTANT_8:
				case ActionValueType.CONSTANT_16:
					str = constant + " (constant)";
					break;
				default:
					str = "unknown";
					break;
			}
			return str;
		}
	}
}
