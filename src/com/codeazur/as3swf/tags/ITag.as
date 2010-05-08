package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.ITimeline;
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.SWFTimeline;
	
	import flash.utils.ByteArray;
	
	public interface ITag
	{
		function get type():uint;
		function get name():String;
		function get version():uint;
		function get level():uint;
		
		function parse(data:SWFData, length:uint, version:uint):void;
		function publish(data:SWFData, version:uint):void;
		function toString(indent:uint = 0):String;
		
		function get parent():SWFTimeline;
		function set parent(value:SWFTimeline):void;
		
		function get rawIndex():uint;
		function set rawIndex(value:uint):void;
		
		function get rawLength():uint;
		function set rawLength(value:uint):void;
	}
}
