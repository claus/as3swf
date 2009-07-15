package com.codeazur.swfalizer.data.filters
{
	import com.codeazur.swfalizer.ISWFDataInput;
	
	public interface IFilter
	{
		function parse(data:ISWFDataInput):void;
	}
}
