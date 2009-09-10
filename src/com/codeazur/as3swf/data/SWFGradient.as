package com.codeazur.as3swf.data
{
	import com.codeazur.as3swf.SWFData;
	
	public class SWFGradient
	{
		public var spreadMode:uint;
		public var interpolationMode:uint;

		// Forward declarations of properties in SWFFocalGradient
		public var focalPoint:Number = 0.0;
		
		protected var _records:Vector.<SWFGradientRecord>;
		
		public function SWFGradient(data:SWFData = null, level:uint = 1) {
			_records = new Vector.<SWFGradientRecord>();
			if (data != null) {
				parse(data, level);
			}
		}
		
		public function get records():Vector.<SWFGradientRecord> { return _records; }
		
		public function parse(data:SWFData, level:uint):void {
			data.resetBitsPending();
			spreadMode = data.readUB(2);
			interpolationMode = data.readUB(2);
			var numGradients:uint = data.readUB(4);
			for (var i:uint = 0; i < numGradients; i++) {
				_records.push(data.readGRADIENTRECORD(level));
			}
		}
		
		public function toString():String {
			return "(" + _records.join(",") + ")";
		}
	}
}
