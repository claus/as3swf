package com.codeazur.as3swf
{
	import com.codeazur.as3swf.timeline.Frame;
	import com.codeazur.as3swf.timeline.Scene;

	public interface ITimeline
	{
		import com.codeazur.as3swf.tags.ITag;
		
		import flash.utils.Dictionary;

		function get bytes():SWFData;
		function get timeline():SWFTimeline;

		function get tags():Vector.<ITag>;
		function get dictionary():Dictionary;
		function get scenes():Vector.<Scene>;
		function get frames():Vector.<Frame>;
		function get layers():Vector.<Array>;
	}
}