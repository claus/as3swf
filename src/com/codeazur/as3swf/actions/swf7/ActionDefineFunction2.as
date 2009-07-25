package com.codeazur.as3swf.actions.swf7
{
	import com.codeazur.as3swf.actions.*;
	import com.codeazur.as3swf.data.SWFRegisterParam;
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.utils.StringUtils;
	
	public class ActionDefineFunction2 extends Action implements IAction
	{
		public var functionName:String;
		public var functionParams:Vector.<SWFRegisterParam>;
		public var functionBody:Vector.<IAction>;
		public var registerCount:uint;
		public var flags:uint;
		
		public function ActionDefineFunction2(code:uint, length:uint) {
			super(code, length);
			functionParams = new Vector.<SWFRegisterParam>();
			functionBody = new Vector.<IAction>();
		}
		
		override public function parse(data:SWFData):void {
			functionName = data.readString();
			var numParams:uint = data.readUI16();
			registerCount = data.readUI8();
			flags = data.readUI16();
			for (var i:uint = 0; i < numParams; i++) {
				functionParams.push(data.readREGISTERPARAM());
			}
			var codeSize:uint = data.readUI16();
			var bodyEndPosition:uint = data.position + codeSize;
			while (data.position < bodyEndPosition) {
				functionBody.push(data.readACTIONRECORD());
			}
		}
		
		public function toString(indent:uint = 0):String {
			var str:String = "[ActionDefineFunction2] " + 
				"Name: " + ((functionName.length > 0) ? functionName : "<anonymous>") + ", " +
				"Params: (" + functionParams.join(", ") + ")";
			for (var i:uint = 0; i < functionBody.length; i++) {
				str += "\n" + StringUtils.repeat(indent + 2) + "[" + i + "] " + functionBody[i].toString(indent + 2);
			}
			return str;
		}
	}
}
