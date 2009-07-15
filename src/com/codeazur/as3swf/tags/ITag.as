package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.ISWFDataInput;
	
	public interface ITag
	{
		function parse(data:ISWFDataInput, length:uint):void;
		function toString(indent:uint = 0):String;
	}
}
