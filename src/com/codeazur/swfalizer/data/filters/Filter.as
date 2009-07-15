package com.codeazur.swfalizer.data.filters
{
	import com.codeazur.swfalizer.ISWFDataInput;
	
	public class Filter
	{
		protected var _id:uint;
		
		public function Filter(id:uint) {
			_id = id;
		}

		public function parse(data:ISWFDataInput):void {}
	}
}
