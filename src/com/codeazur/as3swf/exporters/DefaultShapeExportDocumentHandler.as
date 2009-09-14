package com.codeazur.as3swf.exporters
{
	import flash.display.InterpolationMethod;
	import flash.display.LineScaleMode;
	import flash.display.SpreadMethod;
	import flash.geom.Matrix;
	
	public class DefaultShapeExportDocumentHandler implements IShapeExportDocumentHandler
	{
		public function DefaultShapeExportDocumentHandler() {}
		
		public function beginShape():void {}
		public function endShape():void {}

		public function beginFills():void {}
		public function endFills():void {}

		public function beginLines():void { trace("// Lines:"); }
		public function endLines():void {}
		
		public function beginFill(color:uint, alpha:Number = 1.0):void {}
		public function beginGradientFill(type:String, colors:Array, alphas:Array, ratios:Array, matrix:Matrix = null, spreadMethod:String = SpreadMethod.PAD, interpolationMethod:String = InterpolationMethod.RGB, focalPointRatio:Number = 0):void {}
		public function beginBitmapFill(bitmapId:uint, matrix:Matrix = null, repeat:Boolean = true, smooth:Boolean = false):void {}
		public function endFill():void {}
		
		public function lineStyle(thickness:Number = NaN, color:uint = 0, alpha:Number = 1.0, pixelHinting:Boolean = false, scaleMode:String = LineScaleMode.NORMAL, startCaps:String = null, endCaps:String = null, joints:String = null, miterLimit:Number = 3):void {}

		public function moveTo(x:Number, y:Number):void {}
		public function lineTo(x:Number, y:Number):void {}
		public function curveTo(controlX:Number, controlY:Number, anchorX:Number, anchorY:Number):void {}
	}
}
