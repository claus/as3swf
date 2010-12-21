package com.codeazur.as3swf
{
	import com.codeazur.as3swf.data.SWFRectangle;
	import com.codeazur.as3swf.events.SWFErrorEvent;
	import com.codeazur.as3swf.events.SWFEvent;
	import com.codeazur.as3swf.events.SWFEventDispatcher;
	import com.codeazur.as3swf.tags.IDefinitionTag;
	import com.codeazur.as3swf.tags.ITag;
	import com.codeazur.as3swf.timeline.Frame;
	import com.codeazur.as3swf.timeline.Layer;
	import com.codeazur.as3swf.timeline.Scene;
	
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	public class SWF extends SWFEventDispatcher
	{
		public var version:int = 10;
		public var fileLength:uint = 0;
		public var fileLengthCompressed:uint = 0;
		public var frameSize:SWFRectangle;
		public var frameRate:Number = 50;
		public var frameCount:uint = 1;
		
		public var compressed:Boolean;
		
		public var timeline:SWFTimeline;

		protected var bytes:SWFData;
		
		public function SWF(ba:ByteArray = null) {
			bytes = new SWFData();
			timeline = createTimeline();
			if (ba != null) {
				loadBytes(ba);
			} else {
				frameSize = new SWFRectangle();
			}
		}
		
		// Convenience getters
		public function get tags():Vector.<ITag> { return timeline.tags; }
		public function get dictionary():Dictionary { return timeline.dictionary; }
		public function get scenes():Vector.<Scene> { return timeline.scenes; }
		public function get frames():Vector.<Frame> { return timeline.frames; }
		public function get layers():Vector.<Layer> { return timeline.layers; }

		public function get backgroundColor():uint { return timeline.backgroundColor; }
		
		public function getCharacter(characterId:uint):IDefinitionTag {
			return dictionary[characterId] as IDefinitionTag;
		}
		
		public function loadBytes(ba:ByteArray):void {
			bytes.length = 0;
			ba.position = 0;
			ba.readBytes(bytes);
			parse(bytes);
		}
		
		public function loadBytesAsync(ba:ByteArray):void {
			bytes.length = 0;
			ba.position = 0;
			ba.readBytes(bytes);
			parseAsync(bytes);
		}
		
		public function parse(data:SWFData):void {
			bytes = data;
			parseHeader();
			timeline.parse(bytes, version);
		}
		
		public function parseAsync(data:SWFData):void {
			bytes = data;
			parseHeader();
			if(dispatchEvent(new SWFEvent(SWFEvent.HEADER, data, false, true))) {
				addTimelineListeners();
				timeline.parseAsync(bytes, version);
			}
		}
		
		protected function parseAsyncProgressHandler(event:SWFEvent):void {
			if(!dispatchEvent(event.clone())) {
				event.preventDefault();
				removeTimelineListeners();
			}
		}
		
		protected function parseAsyncCompleteHandler(event:SWFEvent):void {
			dispatchEvent(event.clone());
			removeTimelineListeners();
		}
		
		protected function parseAsyncErrorHandler(event:SWFErrorEvent):void {
			dispatchEvent(event.clone());
			removeTimelineListeners();
		}
		
		protected function parseHeader():void {
			compressed = false;
			bytes.position = 0;
			var signatureByte:uint = bytes.readUI8();
			if (signatureByte == 0x43) {
				compressed = true;
			} else if (signatureByte != 0x46) {
				throw(new Error("Not a SWF. First signature byte is 0x" + signatureByte.toString(16) + " (expected: 0x43 or 0x46)"));
			}
			signatureByte = bytes.readUI8();
			if (signatureByte != 0x57) {
				throw(new Error("Not a SWF. Second signature byte is 0x" + signatureByte.toString(16) + " (expected: 0x57)"));
			}
			signatureByte = bytes.readUI8();
			if (signatureByte != 0x53) {
				throw(new Error("Not a SWF. Third signature byte is 0x" + signatureByte.toString(16) + " (expected: 0x53)"));
			}
			version = bytes.readUI8();
			fileLength = bytes.readUI32();
			fileLengthCompressed = bytes.length;
			if (compressed) {
				// The following data (up to end of file) is compressed, if header has CWS signature
				bytes.swfUncompress();
			}
			frameSize = bytes.readRECT();
			frameRate = bytes.readFIXED8();
			frameCount = bytes.readUI16();
		}
		
		public function publish(ba:ByteArray):void {
			var data:SWFData = new SWFData();
			data.writeUI8(compressed ? 0x43 : 0x46);
			data.writeUI8(0x57);
			data.writeUI8(0x53);
			data.writeUI8(version);
			var fileLengthPos:uint = data.position;
			data.writeUI32(0);
			data.writeRECT(frameSize);
			data.writeFIXED8(frameRate);
			data.writeUI16(frameCount); // TODO: get the real number of frames from the tags
			timeline.publish(data, version);
			fileLength = fileLengthCompressed = data.length;
			if (compressed) {
				data.position = 8;
				data.swfCompress();
				fileLengthCompressed = data.length;
			}
			var endPos:uint = data.position;
			data.position = fileLengthPos;
			data.writeUI32(fileLength);
			data.position = 0;
			ba.length = 0;
			ba.writeBytes(data);
		}
		
		public function createTimeline():SWFTimeline {
			return new SWFTimeline(this);
		}
		
		protected function addTimelineListeners():void {
			timeline.addEventListener(SWFEvent.PROGRESS, parseAsyncProgressHandler);
			timeline.addEventListener(SWFEvent.COMPLETE, parseAsyncCompleteHandler);
			timeline.addEventListener(SWFErrorEvent.ERROR, parseAsyncErrorHandler);
		}
		
		protected function removeTimelineListeners():void {
			timeline.removeEventListener(SWFEvent.PROGRESS, parseAsyncProgressHandler);
			timeline.removeEventListener(SWFEvent.COMPLETE, parseAsyncCompleteHandler);
			timeline.removeEventListener(SWFErrorEvent.ERROR, parseAsyncErrorHandler);
		}
		
		public function toString():String {
			return "[SWF]\n" +
				"  Header:\n" +
				"    Version: " + version + "\n" +
				"    FileLength: " + fileLength + "\n" +
				"    FileLengthCompressed: " + fileLengthCompressed + "\n" +
				"    FrameSize: " + frameSize.toStringSize() + "\n" +
				"    FrameRate: " + frameRate + "\n" +
				"    FrameCount: " + frameCount +
				timeline.toString();
		}
	}
}
