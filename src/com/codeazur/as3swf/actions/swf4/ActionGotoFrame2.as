package com.codeazur.as3swf.actions.swf4
{
	import com.codeazur.as3swf.actions.*;
	import com.codeazur.as3swf.SWFData;
	
	public class ActionGotoFrame2 extends Action implements IAction
	{
		public var sceneBiasFlag:Boolean;
		public var playFlag:Boolean;
		public var sceneBias:uint;
		
		public function ActionGotoFrame2(code:uint, length:uint) {
			super(code, length);
		}
		
		override public function parse(data:SWFData):void {
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
