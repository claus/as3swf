package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.ISWFDataInput;
	import com.codeazur.as3swf.data.SWFColorTransform;
	import com.codeazur.utils.StringUtils;
	
	public class TagDefineButtonCxform extends Tag implements ITag
	{
		public static const TYPE:uint = 23;
		
		public var buttonId:uint;
		public var buttonColorTransform:SWFColorTransform;
		
		public function TagDefineButtonCxform() {}
		
		public function parse(data:ISWFDataInput, length:uint):void {
			buttonId = data.readUI16();
			buttonColorTransform = data.readCXFORM();
		}
		
		public function toString(indent:uint = 0):String {
			var str:String = StringUtils.repeat(indent) + "[" + StringUtils.printf("%02d", TYPE) + ":TagDefineButtonCxform] " +
				"ID: " + buttonId + ", " +
				"ColorTransform: " + buttonColorTransform;
			return str;
		}
	}
}
