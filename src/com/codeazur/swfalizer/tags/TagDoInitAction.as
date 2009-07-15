package com.codeazur.swfalizer.tags
{
	import com.codeazur.swfalizer.ISWFDataInput;
	import com.codeazur.utils.StringUtils;
	
	public class TagDoInitAction extends TagDoAction implements ITag
	{
		public static const TYPE:uint = 59;
		
		public var spriteId:uint;
		
		public function TagDoInitAction() {}
		
		override public function parse(data:ISWFDataInput, length:uint):void {
			spriteId = data.readUI16();
			super.parse(data, length);
		}

		override public function toString(indent:uint = 0):String {
			var str:String = StringUtils.repeat(indent) + "[" + StringUtils.printf("%02d", TYPE) + ":TagDoInitAction] " +
				"SpriteID: " +spriteId + ", ";
				"Records: " + _records.length;
			for (var i:uint = 0; i < _records.length; i++) {
				str += "\n" + StringUtils.repeat(indent + 2) + "[" + i + "] " + _records[i].toString(indent + 2);
			}
			return str;
		}
	}
}
