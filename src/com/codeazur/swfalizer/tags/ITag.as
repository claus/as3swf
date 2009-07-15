package com.codeazur.swfalizer.tags
{
	import com.codeazur.swfalizer.ISWFDataInput;
	
	public interface ITag
	{
		function parse(data:ISWFDataInput, length:uint):void;
		function toString(indent:uint = 0):String;
	}
}
