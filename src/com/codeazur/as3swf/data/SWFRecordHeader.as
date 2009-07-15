package com.codeazur.as3swf.data
{
	public class SWFRecordHeader
	{
		public var type:uint;
		public var length:uint;
		
		public function SWFRecordHeader(type:uint, length:uint)
		{
			this.type = type;
			this.length = length;
		}
	}
}
