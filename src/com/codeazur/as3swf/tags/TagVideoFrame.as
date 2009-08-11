package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	
	import flash.utils.ByteArray;
	
	public class TagVideoFrame extends Tag implements ITag
	{
		public static const TYPE:uint = 61;

		public var streamId:uint;
		public var frameNum:uint;
		
		protected var _videoData:ByteArray;
		
		public function TagVideoFrame() {
			_videoData = new ByteArray();
		}
		
		public function get videoData():ByteArray { return _videoData; }
		
		public function parse(data:SWFData, length:uint, version:uint):void {
			streamId = data.readUI16();
			frameNum = data.readUI16();
			data.readBytes(_videoData, 0, length - 4);
		}
		
		public function publish(data:SWFData, version:uint):void {
			data.writeTagHeader(type, _videoData.length + 4);
			data.writeUI16(streamId);
			data.writeUI16(frameNum);
			if (_videoData.length > 0) {
				data.writeBytes(_videoData);
			}
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "VideoFrame"; }
		override public function get version():uint { return 6; }
		
		public function toString(indent:uint = 0):String {
			return toStringMain(indent) +
				"StreamID: " + streamId + ", " +
				"Frame: " + frameNum;
		}
	}
}
