package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	
	import flash.utils.ByteArray;
	
	public interface ITag
	{
		function get type():uint;
		function get length():uint;
		function get version():uint;
		function get raw():ByteArray;
		function parse(data:SWFData, length:uint):void;
		function publish(data:SWFData):void;
		function toString(indent:uint = 0):String;
	}
}
