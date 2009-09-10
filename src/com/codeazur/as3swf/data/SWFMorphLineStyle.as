package com.codeazur.as3swf.data
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.consts.LineCapsStyle;
	import com.codeazur.as3swf.data.consts.LineJointStyle;
	
	public class SWFMorphLineStyle
	{
		public var startWidth:uint;
		public var endWidth:uint;
		public var startColor:uint;
		public var endColor:uint;

		// Forward declaration of SWFMorphLineStyle2 properties
		public var startCapsStyle:uint = LineCapsStyle.ROUND;
		public var endCapsStyle:uint = LineCapsStyle.ROUND;
		public var jointStyle:uint = LineJointStyle.ROUND;
		public var hasFillFlag:Boolean = false;
		public var noHScaleFlag:Boolean = false;
		public var noVScaleFlag:Boolean = false;
		public var pixelHintingFlag:Boolean = false;
		public var noClose:Boolean = false;
		public var miterLimitFactor:Number = 3;
		public var fillType:SWFMorphFillStyle;
		
		public function SWFMorphLineStyle(data:SWFData = null, level:uint = 1) {
			if (data != null) {
				parse(data, level);
			}
		}
		
		public function parse(data:SWFData, level:uint = 1):void {
			startWidth = data.readUI16();
			endWidth = data.readUI16();
			startColor = data.readRGBA();
			endColor = data.readRGBA();
		}
		
		public function toString():String {
			return "[SWFMorphLineStyle] " +
				"StartWidth: " + startWidth + ", " +
				"EndWidth: " + endWidth + ", " +
				"StartColor: " + startColor.toString(16) + ", " +
				"EndColor: " + endColor.toString(16);
		}
	}
}
