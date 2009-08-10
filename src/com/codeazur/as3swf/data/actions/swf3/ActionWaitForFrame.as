package com.codeazur.as3swf.data.actions.swf3
{
	import com.codeazur.as3swf.data.actions.*;
	import com.codeazur.as3swf.SWFData;
	
	public class ActionWaitForFrame extends Action implements IAction
	{
		public var frame:uint;
		public var skipCount:uint;
		
		public function ActionWaitForFrame(code:uint, length:uint) {
			super(code, length);
		}
		
		override public function parse(data:SWFData):void {
			frame = data.readUI16();
			skipCount = data.readUI8();
		}
		
		override public function publish(data:SWFData):void {
			var body:SWFData = new SWFData();
			body.writeUI16(frame);
			body.writeUI8(skipCount);
			write(data, body);
		}
		
		public function toString(indent:uint = 0):String {
			return "[ActionWaitForFrame] Frame: " + frame + ", SkipCount: " + skipCount;
		}
	}
}
