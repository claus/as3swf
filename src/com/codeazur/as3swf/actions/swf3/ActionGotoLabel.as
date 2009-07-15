package com.codeazur.as3swf.actions.swf3
{
	import com.codeazur.as3swf.actions.*;
	import com.codeazur.as3swf.ISWFDataInput;
	
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
