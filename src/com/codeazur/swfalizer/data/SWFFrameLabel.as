package com.codeazur.swfalizer.data
{
	public class SWFFrameLabel
	{
		public var frameNumber:uint;
		public var name:String;
		
		public function SWFFrameLabel(frameNumber:uint, name:String)
		{
			this.frameNumber = frameNumber;
			this.name = name;
		}
		
		public function toString():String {
			return "FrameNumber: " + frameNumber + ", Name: " + name;
		}
	}
}
