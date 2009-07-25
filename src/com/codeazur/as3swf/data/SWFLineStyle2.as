package com.codeazur.as3swf.data
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.consts.LineCapStyle;
	import com.codeazur.as3swf.data.consts.LineJoinStyle;
	
	public class SWFLineStyle2 extends SWFLineStyle
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
		public var fillType:SWFFillStyle;
		
		public function SWFLineStyle2(data:SWFData = null, level:uint = 1) {
			super(data, level);
		}
		
		override public function parse(data:SWFData, level:uint = 1):void {
			width = data.readUI16();
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
				fillType = data.readFILLSTYLE(level);
			} else {
				color = data.readRGBA();
			}
		}
		
		override public function toString():String {
			var str:String = "[SWFLineStyle2] Width: " + width + ", " +
				"StartCap: " + LineCapStyle.toString(startCapStyle) + ", " +
				"EndCap: " + LineCapStyle.toString(endCapStyle) + ", " +
				"Join: " + LineJoinStyle.toString(joinStyle);
			if (hasFillFlag) {
				str += ", Fill: " + fillType.toString();
			} else {
				str += ", Color: " + color.toString(16);
			}
			return str;
		}
	}
}
