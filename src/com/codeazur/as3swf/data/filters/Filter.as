package com.codeazur.as3swf.data.filters
{
	import com.codeazur.as3swf.SWFData;
	
	public class Filter implements IFilter
	{
		protected var _id:uint;
		
		public function Filter(id:uint) {
			_id = id;
		}

		public function get id():uint { return _id; }
		
		public function parse(data:SWFData):void {
			throw(new Error("Implement in subclasses!"));
		}
		
		public function publish(data:SWFData):void {
			throw(new Error("Implement in subclasses!"));
		}
	}
}
