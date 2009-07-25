package com.codeazur.as3swf.data.filters
{
	import com.codeazur.as3swf.SWFData;
	
	public interface IFilter
	{
		function parse(data:SWFData):void;
	}
}
