package com.codeazur.as3swf.data
{
	public class SWFSymbol
	{
		public var tagId:uint;
		public var name:String;
		
		public function SWFSymbol(tagId:uint, name:String)
		{
			this.tagId = tagId;
			this.name = name;
		}
		
		public function toString():String {
			return "TagID: " + tagId + ", Name: " + name;
		}
	}
}
