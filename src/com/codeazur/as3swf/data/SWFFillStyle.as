package com.codeazur.as3swf.data
{
	public class SWFFillStyle
	{
		public var type:uint;

		public var rgb:uint;
		public var gradient:SWFGradient;
		public var gradientMatrix:SWFMatrix;
		public var bitmapId:uint;
		public var bitmapMatrix:SWFMatrix;
		
		public function SWFFillStyle(type:uint)
		{
			this.type = type;
		}
		
		public function toString():String {
			return "[SWFFillStyle] Type: " + type;
		}
	}
}
