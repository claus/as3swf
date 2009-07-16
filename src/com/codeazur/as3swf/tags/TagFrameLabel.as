package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.ISWFDataInput;
	import com.codeazur.utils.StringUtils;
	
	public class TagFrameLabel extends Tag implements ITag
	{
		public static const TYPE:uint = 43;
		
		public var name:String;
		
		public function TagFrameLabel() {}
		
		public function parse(data:ISWFDataInput, length:uint):void {
			name = data.readString();
		}
		
		public function toString(indent:uint = 0):String {
			return StringUtils.repeat(indent) + "[" + StringUtils.printf("%02d", TYPE) + ":TagFrameLabel] " +
				"Name: " + name;
		}
	}
}
