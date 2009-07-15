package com.codeazur.as3swf.actions
{
	import com.codeazur.as3swf.ISWFDataInput;
	
	public interface IAction
	{
		function parse(data:ISWFDataInput):void;
		function toString(indent:uint = 0):String;
	}
}
