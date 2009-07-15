package com.codeazur.as3swf.actions.swf7
{
	import com.codeazur.as3swf.actions.*;
	import com.codeazur.as3swf.ISWFDataInput;
	import com.codeazur.utils.StringUtils;
	
	public class ActionTry extends Action implements IAction
	{
		public var catchInRegisterFlag:Boolean;
		public var finallyBlockFlag:Boolean;
		public var catchBlockFlag:Boolean;
		public var catchName:String;
		public var catchRegister:uint;
		public var tryBody:Vector.<IAction>;
		public var catchBody:Vector.<IAction>;
		public var finallyBody:Vector.<IAction>;
		
		public function ActionTry(code:uint, length:uint)
		{
			super(code, length);
			tryBody = new Vector.<IAction>();
			catchBody = new Vector.<IAction>();
			finallyBody = new Vector.<IAction>();
		}
		
		override public function parse(data:ISWFDataInput):void {
			var flags:uint = data.readUI8();
			catchInRegisterFlag = ((flags & 0x04) != 0);
			finallyBlockFlag = ((flags & 0x02) != 0);
			catchBlockFlag = ((flags & 0x01) != 0);
			var trySize:uint = data.readUI16();
			var catchSize:uint = data.readUI16();
			var finallySize:uint = data.readUI16();
			if (catchInRegisterFlag) {
				catchRegister = data.readUI8();
			} else {
				catchName = data.readString();
			}
			var tryEndPosition:uint = data.position + trySize;
			while (data.position < tryEndPosition) {
				tryBody.push(data.readACTIONRECORD());
			}
			var catchEndPosition:uint = data.position + catchSize;
			while (data.position < catchEndPosition) {
				catchBody.push(data.readACTIONRECORD());
			}
			var finallyEndPosition:uint = data.position + finallySize;
			while (data.position < finallyEndPosition) {
				finallyBody.push(data.readACTIONRECORD());
			}
		}
		
		public function toString(indent:uint = 0):String {
			var str:String = "[ActionTry] ";
			str += (catchInRegisterFlag) ? "Register: " + catchRegister : "Name: " + catchName;
			var i:uint;
			if (tryBody.length) {
				str += "\n" + StringUtils.repeat(indent + 2) + "Try:";
				for (i = 0; i < tryBody.length; i++) {
					str += "\n" + StringUtils.repeat(indent + 4) + "[" + i + "] " + tryBody[i].toString(indent + 4);
				}
			}
			if (catchBody.length) {
				str += "\n" + StringUtils.repeat(indent + 2) + "Catch:";
				for (i = 0; i < catchBody.length; i++) {
					str += "\n" + StringUtils.repeat(indent + 4) + "[" + i + "] " + catchBody[i].toString(indent + 4);
				}
			}
			if (finallyBody.length) {
				str += "\n" + StringUtils.repeat(indent + 2) + "Finally:";
				for (i = 0; i < finallyBody.length; i++) {
					str += "\n" + StringUtils.repeat(indent + 4) + "[" + i + "] " + finallyBody[i].toString(indent + 4);
				}
			}
			return str;
		}
	}
}
