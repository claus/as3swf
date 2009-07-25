package com.codeazur.as3swf.actions.swf3
{
	import com.codeazur.as3swf.actions.*;
	import com.codeazur.as3swf.SWFData;
	
	public class ActionGotoFrame extends Action implements IAction
	{
		public var frame:uint;
		
		public function ActionGotoFrame(code:uint, length:uint) {
			super(code, length);
		}
		
		override public function parse(data:SWFData):void {
			frame = data.readUI16();
		}
		
		public function toString(indent:uint = 0):String {
			return "[ActionGotoFrame] Frame: " + frame;
		}
	}
}
