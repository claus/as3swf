package com.codeazur.as3swf.data.actions.swf5
{
	import com.codeazur.as3swf.data.actions.*;
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.utils.StringUtils;
	
	public class ActionDefineFunction extends Action implements IAction
	{
		public var functionName:String;
		public var functionParams:Vector.<String>;
		public var functionBody:Vector.<IAction>;
		
		public function ActionDefineFunction(code:uint, length:uint) {
			super(code, length);
			functionParams = new Vector.<String>();
			functionBody = new Vector.<IAction>();
		}
		
		override public function parse(data:SWFData):void {
			functionName = data.readString();
			var count:uint = data.readUI16();
			for (var i:uint = 0; i < count; i++) {
				functionParams.push(data.readString());
			}
			var codeSize:uint = data.readUI16();
			var bodyEndPosition:uint = data.position + codeSize;
			while (data.position < bodyEndPosition) {
				functionBody.push(data.readACTIONRECORD());
			}
		}
		
		public function toString(indent:uint = 0):String {
			var str:String = "[ActionDefineFunction] " + 
				"Name: " + functionName + ", " +
				"Params: (" + functionParams.join(", ") + ")";
			for (var i:uint = 0; i < functionBody.length; i++) {
				str += "\n" + StringUtils.repeat(indent + 2) + "[" + i + "] " + functionBody[i].toString(indent + 2);
			}
			return str;
		}
	}
}
