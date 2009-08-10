package com.codeazur.as3swf.data.actions.swf4
{
	import com.codeazur.as3swf.data.actions.*;
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
			data.readUB(4); // reserved, always 0
			loadTargetFlag = (data.readUB(1) == 1);
			loadVariablesFlag = (data.readUB(1) == 1);
		}
		
		override public function publish(data:SWFData):void {
			var body:SWFData = new SWFData();
			body.writeUB(2, sendVarsMethod);
			body.writeUB(4, 0); // reserved, always 0
			body.writeUB(1, loadTargetFlag ? 1 : 0);
			body.writeUB(1, loadVariablesFlag ? 1 : 0);
			write(data, body);
		}
		
		public function toString(indent:uint = 0):String {
			return "[ActionGetURL2] " +
				"SendVarsMethod: " + sendVarsMethod + ", ";
				"LoadTargetFlag: " + loadTargetFlag + ", ";
				"LoadVariablesFlag: " + loadVariablesFlag;
		}
	}
}
