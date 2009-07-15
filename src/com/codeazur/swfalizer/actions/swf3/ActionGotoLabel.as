package com.codeazur.swfalizer.actions.swf3
{
	import com.codeazur.swfalizer.actions.*;
	import com.codeazur.swfalizer.ISWFDataInput;
	
	public class ActionGotoLabel extends Action implements IAction
	{
		public var label:String;
		
		public function ActionGotoLabel(code:uint, length:uint) {
			super(code, length);
		}
		
		override public function parse(data:ISWFDataInput):void {
			label = data.readString();
		}
		
		public function toString(indent:uint = 0):String {
			return "[ActionGotoLabel] Label: " + label;
		}
	}
}
