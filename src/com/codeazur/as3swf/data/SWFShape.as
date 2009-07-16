package com.codeazur.as3swf.data
{
	import com.codeazur.utils.StringUtils;
	
	public class SWFShape
	{
		protected var _records:Vector.<SWFShapeRecord>;
		
		public function SWFShape()
		{
			_records = new Vector.<SWFShapeRecord>();
		}
		
		public function get records():Vector.<SWFShapeRecord> { return _records; }
		
		public function toString(indent:uint = 0):String {
			var str:String = "\n" + StringUtils.repeat(indent) + "Shapes:";
			for (var i:uint = 0; i < _records.length; i++) {
				str += "\n" + StringUtils.repeat(indent + 2) + _records[i].toString(indent + 2);
			}
			return str;
		}
	}
}
