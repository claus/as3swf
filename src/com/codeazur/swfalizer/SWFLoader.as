package com.codeazur.swfalizer
{
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	
	public class SWFLoader extends EventDispatcher
	{
		protected var loader:URLLoader;
		
		protected var _data:ISWFDataInput;
		
		public function SWFLoader(request:URLRequest = null)
		{
			loader = new URLLoader(request);
			loader.dataFormat = URLLoaderDataFormat.BINARY;
			loader.addEventListener(Event.OPEN, defaultHandler, false, int.MAX_VALUE);
			loader.addEventListener(Event.COMPLETE, completeHandler, false, int.MAX_VALUE);
			loader.addEventListener(ProgressEvent.PROGRESS, defaultHandler, false, int.MAX_VALUE);
			loader.addEventListener(IOErrorEvent.IO_ERROR, defaultHandler, false, int.MAX_VALUE);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, defaultHandler, false, int.MAX_VALUE);
			loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, defaultHandler, false, int.MAX_VALUE);
			loader.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, defaultHandler, false, int.MAX_VALUE);
			if (request != null) {
				load(request);
			}
		}
		
		public function get bytesLoaded():uint {
			return loader.bytesLoaded;
		}
		
		public function get bytesTotal():uint {
			return loader.bytesTotal;
		}
		
		public function get data():ISWFDataInput {
			return _data;
		}
		
		
		public function load(request:URLRequest):void {
			loader.load(request);
		}
		
		public function close():void {
			loader.close();
		}
		
		
		private function completeHandler(e:Event):void {
			_data = new SWFData(loader.data as ByteArray);
			dispatchEvent(e.clone());
		}
		
		protected function defaultHandler(e:Event):void {
			dispatchEvent(e.clone());
		}
	}
}
