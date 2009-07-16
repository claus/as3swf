package com.codeazur.as3swf.data
{
	public class SWFSoundEnvelope
	{
		public var pos44:uint;
		public var leftLevel:uint;
		public var rightLevel:uint;
		
		public function SWFSoundEnvelope(pos44:uint, leftLevel:uint, rightLevel:uint)
		{
			this.pos44 = pos44;
			this.leftLevel = leftLevel;
			this.rightLevel = rightLevel;
		}
		
		public function toString():String {
			return "[SWFSoundEnvelope]";
		}
	}
}
