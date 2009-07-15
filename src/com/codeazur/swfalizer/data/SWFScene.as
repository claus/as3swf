package com.codeazur.swfalizer.data
{
	public class SWFScene
	{
		public var offset:uint;
		public var name:String;
		
		public function SWFScene(offset:uint, name:String)
		{
			this.offset = offset;
			this.name = name;
		}
		
		public function toString():String {
			return "Offset: " + offset + ", Name: " + name;
		}
	}
}
