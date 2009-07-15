package com.codeazur.swfalizer.actions.swf4
{
	import com.codeazur.swfalizer.actions.*;
	import com.codeazur.swfalizer.ISWFDataInput;
	
	public class ActionGotoFrame2 extends Action implements IAction
	{
		public var sceneBiasFlag:Boolean;
		public var playFlag:Boolean;
		public var sceneBias:uint;
		
		public function ActionGotoFrame2(code:uint, length:uint) {
			super(code, length);
		}
		
		override public function parse(data:ISWFDataInput):void {
			var flags:uint = data.readUI8();
			sceneBiasFlag = ((flags & 0x02) != 0);
			playFlag = ((flags & 0x01) != 0);
			if (sceneBiasFlag) {
				sceneBias = data.readUI16();
			}
		}
		
		public function toString(indent:uint = 0):String {
			var str:String = "[ActionGotoFrame2] " +
				"PlayFlag: " + playFlag + ", ";
				"SceneBiasFlag: " + sceneBiasFlag;
			if (sceneBiasFlag) {
				str += ", " + sceneBias;
			}
			return str;
		}
	}
}
