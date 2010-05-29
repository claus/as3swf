package com.codeazur.as3swf.data
{
	import com.codeazur.as3swf.SWFData;
	
	public class SWFMorphGradient
	{
		protected var _records:Vector.<SWFMorphGradientRecord>;
		
		public function SWFMorphGradient(data:SWFData = null, level:uint = 1) {
			_records = new Vector.<SWFMorphGradientRecord>();
			if (data != null) {
				parse(data, level);
			}
		}
		
		public function get records():Vector.<SWFMorphGradientRecord> { return _records; }
		
		public function parse(data:SWFData, level:uint):void {
			var numGradients:uint = data.readUI8();
			for (var i:uint = 0; i < numGradients; i++) {
				_records.push(data.readMORPHGRADIENTRECORD());
			}
		}
		
		public function publish(data:SWFData, level:uint):void {
			var numGradients:uint = _records.length;
			data.writeUI8(numGradients);
			for (var i:uint = 0; i < numGradients; i++) {
				data.writeMORPHGRADIENTRECORD(_records[i]);
			}
		}
		
		public function getMorphedGradient(ratio:Number = 0):SWFGradient {
			var gradient:SWFGradient = new SWFGradient();
			for(var i:uint = 0; i < records.length; i++) {
				gradient.records.push(records[i].getMorphedGradientRecord(ratio)); 
			}
			return gradient;
		}
		
		public function toString():String {
			return "(" + _records.join(",") + ")";
		}
	}
}
