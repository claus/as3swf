package com.codeazur.swfalizer.tags
{
	import com.codeazur.swfalizer.ISWFDataInput;
	import com.codeazur.utils.StringUtils;
	
	public class TagRemoveObject2 extends Tag implements ITag
	{
		public static const TYPE:uint = 28;
		
		public var depth:uint;
		
		public function TagRemoveObject2() {}
		
		public function parse(data:ISWFDataInput, length:uint):void {
			depth = data.readUI16();
		}
		
		public function toString(indent:uint = 0):String {
			return StringUtils.repeat(indent) + "[" + StringUtils.printf("%02d", TYPE) + ":TagRemoveObject2] " +
				"Depth: " + depth;
		}
	}
}
