package com.codeazur.as3swf.actions.swf3
{
	import com.codeazur.as3swf.actions.*;
	import com.codeazur.as3swf.ISWFDataInput;
	
	public class ActionGetURL extends Action implements IAction
	{
		public var urlString:String;
		public var targetString:String;
		
		public function ActionGetURL(code:uint, length:uint) {
			super(code, length);
		}
		
		override public function parse(data:ISWFDataInput):void {
			urlString = data.readString();
			targetString = data.readString();
		}
		
		public function toString(indent:uint = 0):String {
			return "[ActionGetURL] URL: " + urlString + ", Target: " + targetString;
		}
	}
}
