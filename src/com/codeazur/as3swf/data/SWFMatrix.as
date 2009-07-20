package com.codeazur.as3swf.data
{
	import com.codeazur.as3swf.ISWFDataInput;
	
	public class SWFMatrix
	{
		public var scaleX:Number;
		public var scaleY:Number;
		public var rotateSkew0:Number;
		public var rotateSkew1:Number;
		public var translateX:int;
		public var translateY:int;
		
		public function SWFMatrix(data:ISWFDataInput = null) {
			if (data != null) {
				parse(data);
			}
		}
		
		public function parse(data:ISWFDataInput):void {
			data.resetBitsPending();
			scaleX = 1.0;
			scaleY = 1.0;
			if (data.readUB(1) == 1) {
				var scaleBits:uint = data.readUB(5);
				scaleX = data.readFB(scaleBits);
				scaleY = data.readFB(scaleBits);
			}
			rotateSkew0 = 0.0;
			rotateSkew1 = 0.0;
			if (data.readUB(1) == 1) {
				var rotateBits:uint = data.readUB(5);
				rotateSkew0 = data.readFB(rotateBits);
				rotateSkew1 = data.readFB(rotateBits);
			}
			var translateBits:uint = data.readUB(5);
			translateX = data.readSB(translateBits);
			translateY = data.readSB(translateBits);
		}
		
		public function toString():String {
			return "(" + scaleX + "," + scaleY + "," + rotateSkew0 + "," + rotateSkew1 + "," + translateX + "," + translateY + ")";
		}
	}
}
