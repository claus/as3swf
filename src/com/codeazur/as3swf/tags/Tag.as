package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.ITimeline;
	import com.codeazur.as3swf.SWFTimeline;
	import com.codeazur.utils.StringUtils;
	
	import flash.utils.ByteArray;
	
	public class Tag
	{
		protected var _type:uint;
		
		protected var _parent:SWFTimeline;
		protected var _rawIndex:uint;
		protected var _rawLength:uint;
		
		public function Tag() {}
		
		public function get type():uint { return _type; }
		public function get name():String { return "????"; }
		public function get version():uint { return 0; }
		public function get level():uint { return 1; }
		
		public function get parent():SWFTimeline { return _parent; }
		public function set parent(value:SWFTimeline):void { _parent = value; }

		public function get rawIndex():uint { return _rawIndex; }
		public function set rawIndex(value:uint):void { _rawIndex = value; }
		
		public function get rawLength():uint { return _rawLength; }
		public function set rawLength(value:uint):void { _rawLength = value; }
		
		protected function toStringMain(indent:uint = 0):String {
			return StringUtils.repeat(indent) + "[" + StringUtils.printf("%02d", type) + ":" + name + "] ";
		}
	}
}
