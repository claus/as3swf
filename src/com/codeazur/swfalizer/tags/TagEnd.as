package com.codeazur.swfalizer.tags
{
	import com.codeazur.swfalizer.ISWFDataInput;
	import com.codeazur.utils.StringUtils;
	
	public class TagEnd extends Tag implements ITag
	{
		public static const TYPE:uint = 0;
		
		public function TagEnd() {}
		
		public function parse(data:ISWFDataInput, length:uint):void {
			// Do nothing. The End tag has no body.
		}
		
		public function toString(indent:uint = 0):String {
			return StringUtils.repeat(indent) + "[" + StringUtils.printf("%02d", TYPE) + ":TagEnd]";
		}
	}
}
