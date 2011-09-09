package com.codeazur.as3swf
{
	import com.codeazur.as3swf.data.SWFRectangle;
	import com.codeazur.as3swf.events.SWFProgressEvent;
	
	import flash.utils.ByteArray;

	public class SWF extends SWFTimelineContainer
	{
		public var version:int;
		public var fileLength:uint;
		public var fileLengthCompressed:uint;
		public var frameSize:SWFRectangle;
		public var frameRate:Number;
		public var frameCount:uint;
		
		public var compressed:Boolean;
		
		protected var bytes:SWFData;
		
		protected static const FILE_LENGTH_POS:uint = 4;
		protected static const COMPRESSION_START_POS:uint = 8;
		
		public function SWF(ba:ByteArray = null) {
			bytes = new SWFData();
			if (ba != null) {
				loadBytes(ba);
			} else {
				version = 10;
				fileLength = 0;
				fileLengthCompressed = 0;
				frameSize = new SWFRectangle();
				frameRate = 50;
				frameCount = 1;
				compressed = true;
			}
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
			parseTags(data, version);
		}
		
		public function parseAsync(data:SWFData):void {
			bytes = data;
			parseHeader();
			parseTagsAsync(data, version);
		}
		
		public function publish(ba:ByteArray):void {
			var data:SWFData = new SWFData();
			publishHeader(data);
			publishTags(data, version);
			publishFinalize(data);
			ba.writeBytes(data);
		}
		
		public function publishAsync(ba:ByteArray):void {
			var data:SWFData = new SWFData();
			publishHeader(data);
			publishTagsAsync(data, version);
			addEventListener(SWFProgressEvent.COMPLETE, function(event:SWFProgressEvent):void {
				removeEventListener(SWFProgressEvent.COMPLETE, arguments.callee);
				publishFinalize(data);
				ba.length = 0;
				ba.writeBytes(data);
			}, false, int.MAX_VALUE);
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
		
		protected function publishHeader(data:SWFData):void {
			data.writeUI8(compressed ? 0x43 : 0x46);
			data.writeUI8(0x57);
			data.writeUI8(0x53);
			data.writeUI8(version);
			data.writeUI32(0);
			data.writeRECT(frameSize);
			data.writeFIXED8(frameRate);
			data.writeUI16(frameCount); // TODO: get the real number of frames from the tags
		}

		protected function publishFinalize(data:SWFData):void {
			fileLength = fileLengthCompressed = data.length;
			if (compressed) {
				data.position = COMPRESSION_START_POS;
				data.swfCompress();
				fileLengthCompressed = data.length;
			}
			var endPos:uint = data.position;
			data.position = FILE_LENGTH_POS;
			data.writeUI32(fileLength);
			data.position = 0;
		}

		override public function toString(indent:uint = 0):String {
			return "[SWF]\n" +
				"  Header:\n" +
				"    Version: " + version + "\n" +
				"    FileLength: " + fileLength + "\n" +
				"    FileLengthCompressed: " + fileLengthCompressed + "\n" +
				"    FrameSize: " + frameSize.toStringSize() + "\n" +
				"    FrameRate: " + frameRate + "\n" +
				"    FrameCount: " + frameCount +
				super.toString(indent);
		}
	}
}
