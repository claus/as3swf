package com.codeazur.as3swf.events
{
	import com.codeazur.as3swf.SWFData;
	
	import flash.events.Event;
	
	public class SWFEvent extends Event
	{
		public static const HEADER:String = "header";
		public static const PROGRESS:String = "progress";
		public static const COMPLETE:String = "complete";
		
		protected var data:SWFData;
		
		public function SWFEvent(type:String, data:SWFData, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.data = data;
		}
		
		public function get bytesTotal():uint {
			return (data != null) ? data.length : 0;
		}
		
		public function get bytesParsed():uint {
			return (data != null) ? data.position : 0;
		}
		
		override public function clone():Event {
			return new SWFEvent(type, data, bubbles, cancelable);
		}
		
		override public function toString():String {
			return "[SWFParseEvent] bytesTotal: " + bytesTotal + ", bytesParsed: " + bytesParsed;
		}
	}
}