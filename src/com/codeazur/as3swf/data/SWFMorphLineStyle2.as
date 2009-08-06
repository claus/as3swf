package com.codeazur.as3swf.data
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.consts.LineCapStyle;
	import com.codeazur.as3swf.data.consts.LineJoinStyle;
	
	public class SWFMorphLineStyle2 extends SWFMorphLineStyle
	{
		public var startCapStyle:uint = LineCapStyle.ROUND;
		public var endCapStyle:uint = LineCapStyle.ROUND;
		public var joinStyle:uint = LineJoinStyle.ROUND;
		public var hasFillFlag:Boolean;
		public var noHScaleFlag:Boolean;
		public var noVScaleFlag:Boolean;
		public var pixelHintingFlag:Boolean;
		public var noClose:Boolean;
		public var miterLimitFactor:Number;
		public var fillType:SWFMorphFillStyle;
		
		public function SWFMorphLineStyle2(data:SWFData = null, level:uint = 1) {
			super(data, level);
		}
		
		override public function parse(data:SWFData, level:uint = 1):void {
			startWidth = data.readUI16();
			endWidth = data.readUI16();
			startCapStyle = data.readUB(2);
			joinStyle = data.readUB(2);
			hasFillFlag = (data.readUB(1) == 1);
			noHScaleFlag = (data.readUB(1) == 1);
			noVScaleFlag = (data.readUB(1) == 1);
			pixelHintingFlag = (data.readUB(1) == 1);
			var reserved:uint = data.readUB(5);
			noClose = (data.readUB(1) == 1);
			endCapStyle = data.readUB(2);
			if (joinStyle) {
				miterLimitFactor = data.readFIXED8();
			}
			if (hasFillFlag) {
				fillType = data.readMORPHFILLSTYLE(level);
			} else {
				startColor = data.readRGBA();
				endColor = data.readRGBA();
			}
		}
		
		override public function toString():String {
			var str:String = "[SWFMorphLineStyle2] " +
				"StartWidth: " + startWidth + ", " +
				"EndWidth: " + endWidth + ", " +
				"StartCap: " + LineCapStyle.toString(startCapStyle) + ", " +
				"EndCap: " + LineCapStyle.toString(endCapStyle) + ", " +
				"Join: " + LineJoinStyle.toString(joinStyle);
			if (hasFillFlag) {
				str += ", Fill: " + fillType.toString();
			} else {
				str += ", StartColor: " + startColor.toString(16);
				str += ", EndColor: " + endColor.toString(16);
			}
			return str;
		}
	}
}
