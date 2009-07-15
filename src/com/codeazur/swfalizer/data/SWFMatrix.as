package com.codeazur.swfalizer.data
{
	public class SWFMatrix
	{
		public var scaleX:Number;
		public var scaleY:Number;
		public var rotateSkew0:Number;
		public var rotateSkew1:Number;
		public var translateX:int;
		public var translateY:int;
		
		public function SWFMatrix(scaleX:Number, scaleY:Number, rotateSkew0:Number, rotateSkew1:Number, translateX:int, translateY:int)
		{
			this.scaleX = scaleX;
			this.scaleY = scaleY;
			this.rotateSkew0 = rotateSkew0;
			this.rotateSkew1 = rotateSkew1;
			this.translateX = translateX;
			this.translateY = translateY;
		}
		
		public function toString():String {
			return "(" + scaleX + "," + scaleY + "," + rotateSkew0 + "," + rotateSkew1 + "," + Number(translateX) / 20 + "," + Number(translateY) / 20 + ")";
		}
		
		public function toStringTwips():String {
			return "(" + scaleX + "," + scaleY + "," + rotateSkew0 + "," + rotateSkew1 + "," + translateX + "," + translateY + ")";
		}
	}
}
