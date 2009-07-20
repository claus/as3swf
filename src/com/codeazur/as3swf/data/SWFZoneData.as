package com.codeazur.as3swf.data
{
	import com.codeazur.as3swf.ISWFDataInput;
	
	public class SWFZoneData
	{
		public var alignmentCoordinate:Number;
		public var range:Number;
		
		public function SWFZoneData(data:ISWFDataInput = null) {
			if (data != null) {
				parse(data);
			}
		}
		
		public function parse(data:ISWFDataInput):void {
			alignmentCoordinate = data.readFLOAT16();
			range = data.readFLOAT16();
		}
		
		public function toString():String {
			return "(" + alignmentCoordinate + "," + range + ")";
		}
	}
}
