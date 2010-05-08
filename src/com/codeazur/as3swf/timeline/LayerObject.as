package com.codeazur.as3swf.timeline
{
	public class LayerObject
	{
		public var frameNumber:uint;
		public var depth:uint;
		
		public function LayerObject(frameNumber:uint, depth:uint)
		{
			this.frameNumber = frameNumber;
			this.depth = depth;
		}
		
		public function toString():String {
			return frameNumber.toString();
		}
	}
}