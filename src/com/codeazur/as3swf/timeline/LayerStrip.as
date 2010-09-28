package com.codeazur.as3swf.timeline
{
	public class LayerStrip
	{
		public static const TYPE_EMPTY:uint = 0;
		public static const TYPE_SPACER:uint = 1;
		public static const TYPE_STATIC:uint = 2;
		public static const TYPE_MOTIONTWEEN:uint = 3;
		public static const TYPE_SHAPETWEEN:uint = 4;
		
		public var type:uint = TYPE_EMPTY;
		public var startFrameIndex:uint = 0;
		public var endFrameIndex:uint = 0;
		
		public function LayerStrip(type:uint, startFrameIndex:uint, endFrameIndex:uint)
		{
			this.type = type;
			this.startFrameIndex = startFrameIndex;
			this.endFrameIndex = endFrameIndex;
		}
	}
}