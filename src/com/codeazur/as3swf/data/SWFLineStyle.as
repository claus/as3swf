package com.codeazur.as3swf.data
{
	public class SWFLineStyle
	{
		public var width:uint;
		public var color:uint;
		
		public function SWFLineStyle(width:uint)
		{
			this.width = width;
		}
		
		public function toString():String {
			return "[SWFLineStyle] Width: " + width;
		}
	}
}
