package com.codeazur.as3swf.actions.swf3
{
	import com.codeazur.as3swf.actions.*;
	import com.codeazur.as3swf.SWFData;
	
	public class ActionSetTarget extends Action implements IAction
	{
		public var targetName:String;
		
		public function ActionSetTarget(code:uint, length:uint) {
			super(code, length);
		}
		
		override public function parse(data:SWFData):void {
			targetName = data.readString();
		}
		
		public function toString(indent:uint = 0):String {
			return "[ActionSetTarget] TargetName: " + targetName;
		}
	}
}
