package com.codeazur.as3swf.exporters
{
	import com.codeazur.as3swf.SWF;
	import com.codeazur.as3swf.utils.ColorUtils;
	
	import flash.display.GradientType;
	import flash.display.InterpolationMethod;
	import flash.display.LineScaleMode;
	import flash.display.SpreadMethod;
	import flash.geom.Matrix;
	
	public class FXGShapeExporter extends DefaultShapeExporter
	{
		protected var _fxg:XML;
		
		protected var tmpPath:String;
		protected var tmpFill:XML;
		protected var tmpLine:XML;
		
		public function FXGShapeExporter(swf:SWF) {
			super(swf);
		}
		
		public function get fxg():XML { return _fxg; }
		
		/*
		override public function beginShape():void {
			_fxg = <graphic><group /></graphic>;
		}
		
		override public function beginFills():void {
			tmpPath = "";
			tmpFill = <fill />;
			tmpLine = null;
		}

		override public function beginFill(color:uint, alpha:Number = 1.0):void {
			cleanUpGraphicsPath();
			tmpFill.appendChild(<SolidColor color={ColorUtils.rgbToString(color)} alpha={alpha} />);
		}
		
		override public function beginGradientFill(type:String, colors:Array, alphas:Array, ratios:Array, matrix:Matrix = null, spreadMethod:String = SpreadMethod.PAD, interpolationMethod:String = InterpolationMethod.RGB, focalPointRatio:Number = 0):void {
			cleanUpGraphicsPath();
			var gradient:XML;
			if(type == GradientType.LINEAR) {
				gradient = <LinearGradient />;
			} else {
				gradient = <RadialGradient />;
			}
			for(var i:uint = 0; i < colors.length; i++) {
				gradient.appendChild(<GradientEntry color={ColorUtils.rgbToString(colors[i])} alpha={alphas[i]} ratio={ratios[i]} />);
			}
			tmpFill.appendChild(gradient);
		}

		//override public function beginBitmapFill(bitmapId:uint, matrix:Matrix = null, repeat:Boolean = true, smooth:Boolean = false):void {
		//	cleanUpGraphicsPath();
		//	_graphicsData.push(new GraphicsBitmapFill(
		//}
		
		override public function endFill():void {
			cleanUpGraphicsPath();
		}

		override public function lineStyle(thickness:Number = NaN, color:uint = 0, alpha:Number = 1.0, pixelHinting:Boolean = false, scaleMode:String = LineScaleMode.NORMAL, startCaps:String = null, endCaps:String = null, joints:String = null, miterLimit:Number = 3):void {
			cleanUpGraphicsPath();
			tmpPath = "";
			tmpFill = null;
			tmpLine = <stroke />;
		}
		
		override public function moveTo(x:Number, y:Number):void {
			tmpGraphicsPath.moveTo(x, y);
		}
		
		override public function lineTo(x:Number, y:Number):void {
			tmpGraphicsPath.lineTo(x, y);
		}
		
		override public function curveTo(controlX:Number, controlY:Number, anchorX:Number, anchorY:Number):void {
			tmpGraphicsPath.curveTo(controlX, controlY, anchorX, anchorY);
		}
		
		override public function endLines():void {
			cleanUpGraphicsPath();
		}
		
		protected function cleanUpGraphicsPath():void {
			if(tmpGraphicsPath && tmpGraphicsPath.commands && tmpGraphicsPath.commands.length > 0) {
				_graphicsData.push(tmpGraphicsPath);
			}
			tmpGraphicsPath = new GraphicsPath();
		}
		*/
	}
}
