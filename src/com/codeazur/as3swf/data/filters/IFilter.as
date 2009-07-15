package com.codeazur.as3swf.data.filters
{
	import com.codeazur.as3swf.ISWFDataInput;
	
	public interface IFilter
	{
		function parse(data:ISWFDataInput):void;
	}
}
