package com.codeazur.swfalizer.actions
{
	import com.codeazur.swfalizer.ISWFDataInput;
	
	public interface IAction
	{
		function parse(data:ISWFDataInput):void;
		function toString(indent:uint = 0):String;
	}
}
