package com.codeazur.as3swf.data
{
	public class SWFShape
	{
		protected var _records:Vector.<SWFShapeRecord>;
		
		public function SWFShape()
		{
			_records = new Vector.<SWFShapeRecord>();
		}
		
		public function get records():Vector.<SWFShapeRecord> { return _records; }
		
		public function toString():String {
			return "[SWFShape]";
		}
	}
}
