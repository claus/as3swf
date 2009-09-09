package com.codeazur.as3swf.data.etc
{
	import com.codeazur.utils.StringUtils;

	import flash.display.InterpolationMethod;
	import flash.display.LineScaleMode;
	import flash.display.SpreadMethod;
	import flash.geom.Matrix;
	
	public class DefaultShapeExportDocumentHandler implements IShapeExportDocumentHandler
	{
		public function DefaultShapeExportDocumentHandler() {}
		
		public function beginShape():void {}
		public function endShape():void {}
		public function beginFills():void { trace("// Fills:"); }
		public function endFills():void {}
		public function beginLines():void { trace("// Lines:"); }
		public function endLines():void {}
		
		public function beginFill(color:uint, alpha:Number = 1.0):void {
			if (alpha != 1.0) {
				trace(StringUtils.printf("graphics.beginFill(0x%06x, %f);", color, alpha));
			} else {
				trace(StringUtils.printf("graphics.beginFill(0x%06x);", color));
			}
		}
		
		public function beginGradientFill(type:String, colors:Array, alphas:Array, ratios:Array, matrix:Matrix = null, spreadMethod:String = SpreadMethod.PAD, interpolationMethod:String = InterpolationMethod.RGB, focalPointRatio:Number = 0):void {
			trace("graphics.beginGradientFill(###TODO###);");
		}
		
		public function endFill():void {
			trace("graphics.endFill();");
		}
		
		public function lineStyle(thickness:Number = NaN, color:uint = 0, alpha:Number = 1.0, pixelHinting:Boolean = false, scaleMode:String = LineScaleMode.NORMAL, caps:String = null, joints:String = null, miterLimit:Number = 3):void {
			if (miterLimit != 3) {
				trace(StringUtils.printf("graphics.lineStyle(%f, 0x%06x, %f, %s, %s, %s, %s, %f);", 
					thickness, color, alpha, pixelHinting.toString(),
					(scaleMode == null ? "null" : "'" + scaleMode + "'"),
					(caps == null ? "null" : "'" + caps + "'"),
					(joints == null ? "null" : "'" + joints + "'"),
					miterLimit));
			} else if(joints != null) {
				trace(StringUtils.printf("graphics.lineStyle(%f, 0x%06x, %f, %s, %s, %s, %s);", 
					thickness, color, alpha, pixelHinting.toString(),
					(scaleMode == null ? "null" : "'" + scaleMode + "'"),
					(caps == null ? "null" : "'" + caps + "'"),
					(joints == null ? "null" : "'" + joints + "'")));
			} else if(caps != null) {
				trace(StringUtils.printf("graphics.lineStyle(%f, 0x%06x, %f, %s, %s, %s);", 
					thickness, color, alpha, pixelHinting.toString(),
					(scaleMode == null ? "null" : "'" + scaleMode + "'"),
					(caps == null ? "null" : "'" + caps + "'")));
			} else if(scaleMode != LineScaleMode.NORMAL) {
				trace(StringUtils.printf("graphics.lineStyle(%f, 0x%06x, %f, %s, %s);", 
					thickness, color, alpha, pixelHinting.toString(),
					(scaleMode == null ? "null" : "'" + scaleMode + "'")));
			} else if(pixelHinting) {
				trace(StringUtils.printf("graphics.lineStyle(%f, 0x%06x, %f, %s);", 
					thickness, color, alpha, pixelHinting.toString()));
			} else if(alpha != 1.0) {
				trace(StringUtils.printf("graphics.lineStyle(%f, 0x%06x, %f);", thickness, color, alpha));
			} else if(color != 0) {
				trace(StringUtils.printf("graphics.lineStyle(%f, 0x%06x);", thickness, color));
			} else if(!isNaN(thickness)) {
				trace(StringUtils.printf("graphics.lineStyle(%f);", thickness));
			} else {
				trace("graphics.lineStyle();");
			}
		}
		
		public function moveTo(x:Number, y:Number):void {
			trace(StringUtils.printf("graphics.moveTo(%f, %f);", x, y));
		}
		
		public function lineTo(x:Number, y:Number):void {
			trace(StringUtils.printf("graphics.lineTo(%f, %f);", x, y));
		}
		
		public function curveTo(controlX:Number, controlY:Number, anchorX:Number, anchorY:Number):void {
			trace(StringUtils.printf("graphics.curveTo(%f, %f, %f, %f);", controlX, controlY, anchorX, anchorY));
		}
	}
}
