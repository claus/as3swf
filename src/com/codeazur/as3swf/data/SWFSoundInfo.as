package com.codeazur.as3swf.data
{
	import com.codeazur.as3swf.SWFData;
	
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
		
		public function SWFSoundInfo(data:SWFData = null) {
			_envelopeRecords = new Vector.<SWFSoundEnvelope>();
			if (data != null) {
				parse(data);
			}
		}
		
		public function get envelopeRecords():Vector.<SWFSoundEnvelope> { return _envelopeRecords; }
		
		public function parse(data:SWFData):void {
			var flags:uint = data.readUI8();
			syncStop = ((flags & 0x20) != 0);
			syncNoMultiple = ((flags & 0x10) != 0);
			hasEnvelope = ((flags & 0x08) != 0);
			hasLoops = ((flags & 0x04) != 0);
			hasOutPoint = ((flags & 0x02) != 0);
			hasInPoint = ((flags & 0x01) != 0);
			if (hasInPoint) {
				inPoint = data.readUI32();
			}
			if (hasOutPoint) {
				outPoint = data.readUI32();
			}
			if (hasLoops) {
				loopCount = data.readUI16();
			}
			if (hasEnvelope) {
				var envPoints:uint = data.readUI8();
				for (var i:uint = 0; i < envPoints; i++) {
					_envelopeRecords.push(data.readSOUNDENVELOPE());
				}
			}
		}
		
		public function toString():String {
			return "[SWFSoundInfo]";
		}
	}
}
