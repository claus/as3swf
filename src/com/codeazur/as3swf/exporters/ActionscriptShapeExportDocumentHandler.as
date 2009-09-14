package com.codeazur.as3swf.exporters
{
	import com.codeazur.utils.StringUtils;

	import flash.display.InterpolationMethod;
	import flash.display.LineScaleMode;
	import flash.display.SpreadMethod;
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	import flash.geom.Matrix;
	
	public class ActionscriptShapeExportDocumentHandler extends DefaultShapeExportDocumentHandler
	{
		public function ActionscriptShapeExportDocumentHandler() {}
		
		override public function beginFills():void {
			trace("// Fills:"); trace("graphics.lineStyle();");
		}

		override public function beginLines():void {
			trace("// Lines:");
		}
		
		override public function beginFill(color:uint, alpha:Number = 1.0):void {
			if (alpha != 1.0) {
				trace(StringUtils.printf("graphics.beginFill(0x%06x, %f);", color, alpha));
			} else {
				trace(StringUtils.printf("graphics.beginFill(0x%06x);", color));
			}
		}
		
		override public function beginGradientFill(type:String, colors:Array, alphas:Array, ratios:Array, matrix:Matrix = null, spreadMethod:String = SpreadMethod.PAD, interpolationMethod:String = InterpolationMethod.RGB, focalPointRatio:Number = 0):void {
			var asMatrix:String = "null";
			if (matrix != null) {
				asMatrix = "new Matrix(" + 
					matrix.a + "," + 
					matrix.b + "," + 
					matrix.c + "," + 
					matrix.d + "," + 
					matrix.tx + "," + 
					matrix.ty + ")";
			}
			var asColors:String = "";
			for (var i:uint = 0; i < colors.length; i++) {
				asColors += StringUtils.printf("0x%06x", colors[i]);
				if (i < colors.length - 1) { asColors += ","; }
			}
			if (focalPointRatio != 0.0) {
				trace(StringUtils.printf("graphics.beginGradientFill('%s', [%s], [%s], [%s], %s, '%s', '%s', %s);", 
					type,
					asColors,
					alphas.join(","),
					ratios.join(","),
					asMatrix,
					spreadMethod,
					interpolationMethod,
					focalPointRatio.toString()));
			} else if (interpolationMethod != InterpolationMethod.RGB) {
				trace(StringUtils.printf("graphics.beginGradientFill('%s', [%s], [%s], [%s], %s, '%s', '%s');", 
					type,
					asColors,
					alphas.join(","),
					ratios.join(","),
					asMatrix,
					spreadMethod,
					interpolationMethod));
			} else if (spreadMethod != SpreadMethod.PAD) {
				trace(StringUtils.printf("graphics.beginGradientFill('%s', [%s], [%s], [%s], %s, '%s');", 
					type,
					asColors,
					alphas.join(","),
					ratios.join(","),
					asMatrix,
					spreadMethod));
			} else if (matrix != null) {
				trace(StringUtils.printf("graphics.beginGradientFill('%s', [%s], [%s], [%s], %s);", 
					type,
					asColors,
					alphas.join(","),
					ratios.join(","),
					asMatrix));
			} else {
				trace(StringUtils.printf("graphics.beginGradientFill('%s', [%s], [%s], [%s]);", 
					type,
					asColors,
					alphas.join(","),
					ratios.join(",")));
			}
		}

		override public function beginBitmapFill(bitmapId:uint, matrix:Matrix = null, repeat:Boolean = true, smooth:Boolean = false):void {
			var asMatrix:String = "null";
			if (matrix != null) {
				asMatrix = "new Matrix(" + 
					matrix.a + "," + 
					matrix.b + "," + 
					matrix.c + "," + 
					matrix.d + "," + 
					matrix.tx + "," + 
					matrix.ty + ")";
			}
			if (smooth) {
				trace(StringUtils.printf("// graphics.beginBitmapFill(%d, %s, %s, %s);", bitmapId, asMatrix, repeat, smooth));
			} else if (!repeat) {
				trace(StringUtils.printf("// graphics.beginBitmapFill(%d, %s, %s, %s);", bitmapId, asMatrix, repeat));
			} else {
				trace(StringUtils.printf("// graphics.beginBitmapFill(%d, %s, %s, %s);", bitmapId, asMatrix));
			}
		}
		
		override public function endFill():void {
			trace("graphics.endFill();");
		}
		
		override public function lineStyle(thickness:Number = NaN, color:uint = 0, alpha:Number = 1.0, pixelHinting:Boolean = false, scaleMode:String = LineScaleMode.NORMAL, startCaps:String = null, endCaps:String = null, joints:String = null, miterLimit:Number = 3):void {
			if (miterLimit != 3) {
				trace(StringUtils.printf("graphics.lineStyle(%f, 0x%06x, %f, %s, %s, %s, %s, %f);", 
					thickness, color, alpha, pixelHinting.toString(),
					(scaleMode == null ? "null" : "'" + scaleMode + "'"),
					(startCaps == null ? "null" : "'" + startCaps + "'"),
					(joints == null ? "null" : "'" + joints + "'"),
					miterLimit));
			} else if (joints != null && joints != JointStyle.ROUND) {
				trace(StringUtils.printf("graphics.lineStyle(%f, 0x%06x, %f, %s, %s, %s, %s);", 
					thickness, color, alpha, pixelHinting.toString(),
					(scaleMode == null ? "null" : "'" + scaleMode + "'"),
					(startCaps == null ? "null" : "'" + startCaps + "'"),
					"'" + joints + "'"));
			} else if(startCaps != null && startCaps != CapsStyle.ROUND) {
				trace(StringUtils.printf("graphics.lineStyle(%f, 0x%06x, %f, %s, %s, %s);", 
					thickness, color, alpha, pixelHinting.toString(),
					(scaleMode == null ? "null" : "'" + scaleMode + "'"),
					"'" + startCaps + "'"));
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
		
		override public function moveTo(x:Number, y:Number):void {
			trace(StringUtils.printf("graphics.moveTo(%f, %f);", x, y));
		}
		
		override public function lineTo(x:Number, y:Number):void {
			trace(StringUtils.printf("graphics.lineTo(%f, %f);", x, y));
		}
		
		override public function curveTo(controlX:Number, controlY:Number, anchorX:Number, anchorY:Number):void {
			trace(StringUtils.printf("graphics.curveTo(%f, %f, %f, %f);", controlX, controlY, anchorX, anchorY));
		}
	}
}
