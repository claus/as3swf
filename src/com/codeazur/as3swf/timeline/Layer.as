package com.codeazur.as3swf.timeline
{
	public class Layer
	{
		public var depth:uint = 0;
		public var frameCount:uint = 0;
		
		public var frameStripMap:Array;
		public var strips:Array;
		
		public function Layer(depth:uint, frameCount:uint)
		{
			this.depth = depth;
			this.frameCount = frameCount;
			frameStripMap = [];
			strips = [];
		}
		
		public function appendStrip(type:uint, start:uint, end:uint):void {
			if(type != LayerStrip.TYPE_EMPTY) {
				var i:uint;
				var stripIndex:uint = strips.length;
				if(stripIndex == 0 && start > 0) {
					for(i = 0; i < start; i++) {
						frameStripMap[i] = stripIndex;
					}
					strips[stripIndex++] = new LayerStrip(LayerStrip.TYPE_SPACER, 0, start - 1);
				} else if(stripIndex > 0) {
					var prevStrip:LayerStrip = strips[stripIndex - 1] as LayerStrip;
					if(prevStrip.endFrameIndex + 1 < start) {
						for(i = prevStrip.endFrameIndex + 1; i < start; i++) {
							frameStripMap[i] = stripIndex;
						}
						strips[stripIndex++] = new LayerStrip(LayerStrip.TYPE_SPACER, prevStrip.endFrameIndex + 1, start - 1);
					}
				}
				for(i = start; i <= end; i++) {
					frameStripMap[i] = stripIndex;
				}
				strips[stripIndex] = new LayerStrip(type, start, end);
			}
		}
		
		public function getStripsForFrameRegion(start:uint, end:uint):Array {
			if(start >= frameStripMap.length || end < start) {
				return [];
			}
			var startStripIndex:uint = frameStripMap[start];
			var endStripIndex:uint = (end >= frameStripMap.length) ? strips.length - 1 : frameStripMap[end];
			return strips.slice(startStripIndex, endStripIndex + 1);
		}
	}
}