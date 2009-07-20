package com.codeazur.as3swf.data
{
	import com.codeazur.as3swf.ISWFDataInput;
	
	public class SWFZoneRecord
	{
		public var maskX:Boolean;
		public var maskY:Boolean;

		protected var _data:Vector.<SWFZoneData>;
		
		public function SWFZoneRecord(data:ISWFDataInput = null) {
			_data = new Vector.<SWFZoneData>();
			if (data != null) {
				parse(data);
			}
		}
		
		public function get data():Vector.<SWFZoneData> { return _data; }
		
		public function parse(data:ISWFDataInput):void {
			var numZoneData:uint = data.readUI8();
			for (var i:uint = 0; i < numZoneData; i++) {
				_data.push(data.readZONEDATA());
			}
			var mask:uint = data.readUI8();
			maskX = ((mask & 0x01) != 0);
			maskY = ((mask & 0x02) != 0);
		}
		
		public function toString():String {
			return data.toString() + "," + maskX + "," + maskY;
		}
	}
}
