package com.codeazur.as3swf.data
{
	public class SWFZoneRecord
	{
		protected var _data:Vector.<SWFZoneData>;

		public var maskX:Boolean;
		public var maskY:Boolean;
		
		public function SWFZoneRecord()
		{
			_data = new Vector.<SWFZoneData>();
		}
		
		public function get data():Vector.<SWFZoneData> { return _data; }
		
		public function toString():String {
			return data.toString() + "," + maskX + "," + maskY;
		}
	}
}
