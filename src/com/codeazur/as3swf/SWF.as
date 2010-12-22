package com.codeazur.as3swf
{
	import com.codeazur.as3swf.data.SWFRectangle;
	import com.codeazur.as3swf.events.SWFEvent;
	
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
			parseTags(bytes, version);
		}
		
		public function parseAsync(data:SWFData):void {
			bytes = data;
			parseHeader();
			if(dispatchEvent(new SWFEvent(SWFEvent.HEADER, data, false, true))) {
				parseTagsAsync(bytes, version);
			}
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
			publishTags(data, version);
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
