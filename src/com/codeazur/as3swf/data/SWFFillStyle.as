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
			var str:String = "[SWFFillStyle] Type: " + type.toString(16);
			switch(type) {
				case 0x00: str += " (solid), Color: " + rgb.toString(16); break;
				case 0x10: str += " (linear gradient), Gradient: " + gradient + ", Matrix: " + gradientMatrix; break;
				case 0x12: str += " (radial gradient), Gradient: " + gradient + ", Matrix: " + gradientMatrix; break;
				case 0x13: str += " (focal radial gradient), Gradient: " + gradient + ", Matrix: " + gradientMatrix; break;
				case 0x40: str += " (repeating bitmap), BitmapID: " + bitmapId + ", BitmapMatrix: " + bitmapMatrix; break;
				case 0x41: str += " (clipped bitmap), BitmapID: " + bitmapId + ", BitmapMatrix: " + bitmapMatrix; break;
				case 0x42: str += " (non-smoothed repeating bitmap), BitmapID: " + bitmapId + ", BitmapMatrix: " + bitmapMatrix; break;
				case 0x43: str += " (non-smoothed clipped bitmap), BitmapID: " + bitmapId + ", BitmapMatrix: " + bitmapMatrix; break;
			}
			return str;
		}
	}
}
