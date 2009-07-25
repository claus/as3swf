package com.codeazur.as3swf.actions
{
	import com.codeazur.as3swf.SWFData;
	
	public interface IAction
	{
		function parse(data:SWFData):void;
		function toString(indent:uint = 0):String;
	}
}
