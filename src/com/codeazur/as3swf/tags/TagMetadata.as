package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.ISWFDataInput;
	import com.codeazur.utils.StringUtils;
	
	public class TagMetadata extends Tag implements ITag
	{
		public static const TYPE:uint = 77;
		
		public var xmlString:String;
		
		public function TagMetadata() {}
		
		public function parse(data:ISWFDataInput, length:uint):void {
			xmlString = data.readString();
		}
		
		public function toString(indent:uint = 0):String {
			return StringUtils.repeat(indent) + "[" + StringUtils.printf("%02d", TYPE) + ":TagMetadata]";
		}
	}
}
