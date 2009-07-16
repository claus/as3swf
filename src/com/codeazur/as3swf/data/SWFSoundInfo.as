package com.codeazur.as3swf.data
{
	public class SWFSoundInfo
	{
		public var syncStop:Boolean;
		public var syncNoMultiple:Boolean;
		public var hasEnvelope:Boolean;
		public var hasLoops:Boolean;
		public var hasOutPoint:Boolean;
		public var hasInPoint:Boolean;
		public var outPoint:uint;
		public var inPoint:uint;
		public var loopCount:uint;
		
		protected var _envelopeRecords:Vector.<SWFSoundEnvelope>;
		
		public function SWFSoundInfo(flags:uint)
		{
			syncStop = ((flags & 0x20) != 0);
			syncNoMultiple = ((flags & 0x10) != 0);
			hasEnvelope = ((flags & 0x08) != 0);
			hasLoops = ((flags & 0x04) != 0);
			hasOutPoint = ((flags & 0x02) != 0);
			hasInPoint = ((flags & 0x01) != 0);
			
			_envelopeRecords = new Vector.<SWFSoundEnvelope>();
		}
		
		public function get envelopeRecords():Vector.<SWFSoundEnvelope> { return _envelopeRecords; }
		
		public function toString():String {
			return "[SWFSoundInfo]";
		}
	}
}
