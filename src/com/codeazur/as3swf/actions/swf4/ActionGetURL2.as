package com.codeazur.as3swf.actions.swf4
{
	import com.codeazur.as3swf.actions.*;
	import com.codeazur.as3swf.SWFData;
	
	public class ActionGetURL2 extends Action implements IAction
	{
		public var sendVarsMethod:uint;
		public var loadTargetFlag:Boolean;
		public var loadVariablesFlag:Boolean;
		
		public function ActionGetURL2(code:uint, length:uint) {
			super(code, length);
		}
		
		override public function parse(data:SWFData):void {
			sendVarsMethod = data.readUB(2);
			data.readUB(4);
			loadTargetFlag = (data.readUB(1) == 1);
			loadVariablesFlag = (data.readUB(1) == 1);
		}
		
		public function toString(indent:uint = 0):String {
			return "[ActionGetURL2] " +
				"SendVarsMethod: " + sendVarsMethod + ", ";
				"LoadTargetFlag: " + loadTargetFlag + ", ";
				"LoadVariablesFlag: " + loadVariablesFlag;
		}
	}
}
