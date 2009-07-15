package com.codeazur.as3swf.data.filters
{
	import com.codeazur.as3swf.ISWFDataInput;
	
	public class Filter
	{
		protected var _id:uint;
		
		public function Filter(id:uint) {
			_id = id;
		}

		public function parse(data:ISWFDataInput):void {}
	}
}
