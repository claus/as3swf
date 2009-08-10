package com.codeazur.as3swf.data.actions.swf3
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.actions.*;
	
	public class ActionGetURL extends Action implements IAction
	{
		public var urlString:String;
		public var targetString:String;
		
		public function ActionGetURL(code:uint, length:uint) {
			super(code, length);
		}
		
		override public function parse(data:SWFData):void {
			urlString = data.readString();
			targetString = data.readString();
		}
		
		override public function publish(data:SWFData):void {
			var body:SWFData = new SWFData();
			body.writeString(urlString);
			body.writeString(targetString);
			write(data, body);
		}
		
		public function toString(indent:uint = 0):String {
			return "[ActionGetURL] URL: " + urlString + ", Target: " + targetString;
		}
	}
}
