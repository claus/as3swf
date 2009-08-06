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
		
		public function toString():String {
			return "(" + _records.join(",") + ")";
		}
	}
}
