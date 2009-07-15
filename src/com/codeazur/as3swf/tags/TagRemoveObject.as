package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.ISWFDataInput;
	import com.codeazur.utils.StringUtils;
	
	public class TagRemoveObject extends Tag implements ITag
	{
		public static const TYPE:uint = 5;
		
		public var characterId:uint;
		public var depth:uint;
		
		public function TagRemoveObject() {}
		
		public function parse(data:ISWFDataInput, length:uint):void {
			characterId = data.readUI16();
			depth = data.readUI16();
		}
		
		public function toString(indent:uint = 0):String {
			return StringUtils.repeat(indent) + "[" + StringUtils.printf("%02d", TYPE) + ":TagRemoveObject] " +
				"CharacterID: " + characterId + ", " +
				"Depth: " + depth;
		}
	}
}
