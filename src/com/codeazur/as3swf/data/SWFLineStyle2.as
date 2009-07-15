package com.codeazur.as3swf.data
{
	public class SWFLineStyle2 extends SWFLineStyle
	{
		public static const CAPSTYLE_ROUND:uint = 0;
		public static const CAPSTYLE_NO:uint = 1;
		public static const CAPSTYLE_SQUARE:uint = 2;

		public static const JOINSTYLE_ROUND:uint = 0;
		public static const JOINSTYLE_BEVEL:uint = 1;
		public static const JOINSTYLE_MITER:uint = 2;
		
		public var startCapStyle:uint = CAPSTYLE_ROUND;
		public var endCapStyle:uint = CAPSTYLE_ROUND;
		public var joinStyle:uint = JOINSTYLE_ROUND;
		public var hasFillFlag:Boolean;
		public var noHScaleFlag:Boolean;
		public var noVScaleFlag:Boolean;
		public var pixelHintingFlag:Boolean;
		public var noClose:Boolean;
		public var miterLimitFactor:Number;
		public var fillType:SWFFillStyle;
		
		public function SWFLineStyle2(width:uint)
		{
			super(width);
		}
		
		override public function toString():String {
			return "[SWFLineStyle2] Width: " + width;
		}
	}
}
