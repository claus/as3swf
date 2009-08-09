package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	
	import flash.utils.ByteArray;
	
	public interface ITag
	{
		function get type():uint;
		function get name():String;
		function get version():uint;
		
		function parse(data:SWFData, length:uint, version:uint):void;
		function publish(data:SWFData, version:uint):void;
		function toString(indent:uint = 0):String;

		function get raw():ByteArray;
		function set raw(value:ByteArray):void;
	}
}
