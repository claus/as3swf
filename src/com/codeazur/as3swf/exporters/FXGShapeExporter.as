package com.codeazur.as3swf.exporters
{
	import com.codeazur.as3swf.SWF;
	import com.codeazur.as3swf.utils.ColorUtils;
	import com.codeazur.as3swf.utils.NumberUtils;
	
	import flash.display.CapsStyle;
	import flash.display.GradientType;
	import flash.display.InterpolationMethod;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.SpreadMethod;
	import flash.geom.Matrix;
	
	public class FXGShapeExporter extends DefaultShapeExporter
	{
		protected static const DRAW_COMMAND_L:String = "L";
		protected static const DRAW_COMMAND_Q:String = "Q";

		protected static const s:Namespace = new Namespace("s", "library://ns.adobe.com/flex/spark");
		
		protected var _fxg:XML;
		
		protected var currentDrawCommand:String = "";
		protected var pathData:String;
		protected var path:XML;
		
		public function FXGShapeExporter(swf:SWF) {
			super(swf);
		}
		
		public function get fxg():XML { return _fxg; }
		
		override public function beginShape():void {
			_fxg = <s:Graphic xmlns:s={s.uri}><s:Group /></s:Graphic>;
		}
		
		override public function beginFill(color:uint, alpha:Number = 1.0):void {
			finalizePath();
			var fill:XML = <s:fill xmlns:s={s.uri} />;
			var solidColor:XML = <s:SolidColor xmlns:s={s.uri} />;
			if(color != 0) { solidColor.@color = ColorUtils.rgbToString(color); }
			if(alpha != 1) { solidColor.@alpha = alpha; }
			fill.appendChild(solidColor);
			path.appendChild(fill);
		}
		
		override public function beginGradientFill(type:String, colors:Array, alphas:Array, ratios:Array, matrix:Matrix = null, spreadMethod:String = SpreadMethod.PAD, interpolationMethod:String = InterpolationMethod.RGB, focalPointRatio:Number = 0):void {
			finalizePath();
			var gradient:XML;
			var fill:XML = <s:fill xmlns:s={s.uri} />;
			if(type == GradientType.LINEAR) {
				gradient = <s:LinearGradient xmlns:s={s.uri} />;
			} else {
				gradient = <s:RadialGradient xmlns:s={s.uri} />;
				if(focalPointRatio != 0) { gradient.@focalPointRatio = focalPointRatio; }
			}
			if(spreadMethod != SpreadMethod.PAD) { gradient.@spreadMethod = spreadMethod; }
			if(interpolationMethod != InterpolationMethod.RGB) { gradient.@interpolationMethod = interpolationMethod; }
			if(matrix) {
				var mult:Number = 32768 / 20;
				gradient.appendChild(<s:matrix xmlns:s={s.uri}>
					<s:Matrix tx={matrix.tx/20} ty={matrix.ty/20} a={matrix.a*mult} b={matrix.b*mult} c={matrix.c*mult} d={matrix.d*mult} />
				</s:matrix>);
			}
			for(var i:uint = 0; i < colors.length; i++) {
				gradient.appendChild(<s:GradientEntry xmlns:s={s.uri} color={ColorUtils.rgbToString(colors[i])} alpha={alphas[i]} ratio={ratios[i]/255} />);
			}
			fill.appendChild(gradient);
			path.appendChild(fill);
		}

		override public function beginBitmapFill(bitmapId:uint, matrix:Matrix = null, repeat:Boolean = true, smooth:Boolean = false):void {
			throw(new Error("Bitmap fills are not yet supported for shape export."));
		}
		
		override public function endFill():void {
			finalizePath();
		}

		override public function lineStyle(thickness:Number = NaN, color:uint = 0, alpha:Number = 1.0, pixelHinting:Boolean = false, scaleMode:String = LineScaleMode.NORMAL, startCaps:String = null, endCaps:String = null, joints:String = null, miterLimit:Number = 3):void {
			finalizePath();
			var stroke:XML = <s:stroke xmlns:s={s.uri} />;
			var solidColorStroke:XML = <s:SolidColorStroke xmlns:s={s.uri} />;
			if(!isNaN(thickness) && thickness != 1) { solidColorStroke.@weight = thickness; }
			if(color != 0) { solidColorStroke.@color = ColorUtils.rgbToString(color); }
			if(alpha != 1) { solidColorStroke.@alpha = alpha; }
			if(pixelHinting) { solidColorStroke.@pixelHinting = "true"; }
			if(scaleMode != LineScaleMode.NORMAL) { solidColorStroke.@scaleMode = scaleMode; }
			if(startCaps && startCaps != CapsStyle.ROUND) { solidColorStroke.@caps = startCaps; }
			if(joints && joints != JointStyle.ROUND) { solidColorStroke.@joints = joints; }
			if(miterLimit != 3) { solidColorStroke.@miterLimit = miterLimit; }
			stroke.appendChild(solidColorStroke);
			path.appendChild(stroke);
		}
		
		override public function moveTo(x:Number, y:Number):void {
			currentDrawCommand = "";
			pathData += "M" +
				NumberUtils.roundPixels20(x) + " " + 
				NumberUtils.roundPixels20(y) + " ";
		}
		
		override public function lineTo(x:Number, y:Number):void {
			if(currentDrawCommand != DRAW_COMMAND_L) {
				currentDrawCommand = DRAW_COMMAND_L;
				pathData += "L";
			}
			pathData += 
				NumberUtils.roundPixels20(x) + " " + 
				NumberUtils.roundPixels20(y) + " ";
		}
		
		override public function curveTo(controlX:Number, controlY:Number, anchorX:Number, anchorY:Number):void {
			if(currentDrawCommand != DRAW_COMMAND_Q) {
				currentDrawCommand = DRAW_COMMAND_Q;
				pathData += "Q";
			}
			pathData += 
				NumberUtils.roundPixels20(controlX) + " " + 
				NumberUtils.roundPixels20(controlY) + " " + 
				NumberUtils.roundPixels20(anchorX) + " " + 
				NumberUtils.roundPixels20(anchorY) + " ";
		}
		
		override public function endLines():void {
			finalizePath();
		}

		
		protected function finalizePath():void {
			if(path && pathData != "") {
				path.@data = pathData;
				fxg.s::Group.appendChild(path);
			}
			pathData = "";
			currentDrawCommand = "";
			path = <s:Path xmlns:s={s.uri} />;
		}
	}
}
