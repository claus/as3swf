package com.codeazur.as3swf.data
{
	import com.codeazur.as3swf.SWFData;
	
	import flash.geom.Matrix;
	
	public class SWFMatrix
	{
		public var scaleX:Number = 1.0;
		public var scaleY:Number = 1.0;
		public var rotateSkew0:Number = 0.0;
		public var rotateSkew1:Number = 0.0;
		public var translateX:int = 0.0;
		public var translateY:int = 0.0;
		
		public function SWFMatrix(data:SWFData = null) {
			if (data != null) {
				parse(data);
			}
		}
		
		public function get matrix():Matrix {
			return new Matrix(scaleX, rotateSkew0, rotateSkew1, scaleY, translateX, translateY);
		}
		
		public function parse(data:SWFData):void {
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
