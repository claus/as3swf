package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	
	public class TagEnableDebugger2 extends TagEnableDebugger implements ITag
	{
		public static const TYPE:uint = 64;
		
		public function TagEnableDebugger2() {}
		
		override public function parse(data:SWFData, length:uint, version:uint):void {
			data.readUI16(); // reserved, always 0
			if (length > 2) {
				data.readBytes(_password, 0, length - 2);
			}
		}
		
		override public function publish(data:SWFData, version:uint):void {
			data.writeTagHeader(type, _password.length + 2);
			data.writeUI16(0); // reserved, always 0
			if (_password.length > 0) {
				data.writeBytes(_password);
			}
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "EnableDebugger2"; }
		override public function get version():uint { return 6; }
	}
}
