package com.codeazur.as3swf
{
	import com.codeazur.as3swf.data.SWFRectangle;
	import com.codeazur.as3swf.tags.ITag;
	
	import flash.utils.ByteArray;
	
	public class SWF
	{
		public var version:int = 10;
		public var fileLength:uint = 0;
		public var fileLengthCompressed:uint = 0;
		public var frameSize:SWFRectangle;
		public var frameRate:Number = 50;
		public var frameCount:uint = 1;

		public var compressed:Boolean;
		
		protected var _timeline:SWFTimeline;
		
		public function SWF(data:ByteArray = null) {
			_timeline = new SWFTimeline();
			if (data != null) {
				loadBytes(data);
			} else {
				frameSize = new SWFRectangle();
			}
		}
		
		public function get timeline():SWFTimeline { return _timeline; }
		
		public function getTagByCharacterId(characterId:uint):ITag {
			return timeline.getTagByCharacterId(characterId);
		}
		
		public function loadBytes(data:ByteArray):void {
			var swfData:SWFData = new SWFData();
			data.position = 0;
			data.readBytes(swfData, 0, data.length);
			swfData.position = 0;
			parse(swfData);
		}
		
		public function parse(data:SWFData):void {
			compressed = false;
			var signatureByte:uint = data.readUI8();
			if (signatureByte == 0x43) {
				compressed = true;
			} else if (signatureByte != 0x46) {
				throw(new Error("Not a SWF. First signature byte is 0x" + signatureByte.toString(16) + " (expected: 0x43 or 0x46)"));
			}
			signatureByte = data.readUI8();
			if (signatureByte != 0x57) {
				throw(new Error("Not a SWF. Second signature byte is 0x" + signatureByte.toString(16) + " (expected: 0x57)"));
			}
			signatureByte = data.readUI8();
			if (signatureByte != 0x53) {
				throw(new Error("Not a SWF. Third signature byte is 0x" + signatureByte.toString(16) + " (expected: 0x53)"));
			}
			version = data.readUI8();
			fileLength = data.readUI32();
			fileLengthCompressed = data.length;
			if (compressed) {
				// The following data (up to end of file) is compressed, if header has CWS signature
				data.swfUncompress();
			}
			frameSize = data.readRECT();
			frameRate = data.readFIXED8();
			frameCount = data.readUI16();
			timeline.parse(data, version);
		}
		
		public function publish(data:SWFData):void {
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
			data.position = endPos;
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
