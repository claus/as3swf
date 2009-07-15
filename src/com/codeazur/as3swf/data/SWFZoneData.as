package com.codeazur.as3swf.data
{
	public class SWFZoneData
	{
		public var alignmentCoordinate:Number;
		public var range:Number;
		
		public function SWFZoneData(alignmentCoordinate:Number, range:Number)
		{
			this.alignmentCoordinate = alignmentCoordinate;
			this.range = range;
		}
		
		public function toString():String {
			return "(" + alignmentCoordinate + "," + range + ")";
		}
	}
}
