package com.codeazur.as3swf
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.SWFRecordHeader;
	import com.codeazur.as3swf.data.SWFRectangle;
	import com.codeazur.as3swf.factories.SWFTagFactory;
	import com.codeazur.as3swf.tags.ITag;
	import com.codeazur.as3swf.tags.Tag;

	import flash.utils.IDataInput;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	
	import flash.system.System;
	
	public class SWF
	{
		public var version:int;
		public var fileLength:uint;
		public var fileLengthCompressed:uint;
		public var frameSize:SWFRectangle;
		public var frameRate:Number;
		public var frameCount:uint;

		public var compressed:Boolean;
		
		protected var _tags:Vector.<ITag>;

		public function SWF(data:ByteArray = null) {
			_tags = new Vector.<ITag>();
			if (data != null) {
				loadBytes(data);
			}
		}
		
		public function get tags():Vector.<ITag> { return _tags; }
		
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
				data.swfUncompress();
			}
			frameSize = data.readRECT();
			frameRate = data.readFIXED8();
			frameCount = data.readUI16();
			tags.length = 0;
			var t:uint = getTimer();
			while (true) {
				var raw:ByteArray = data.readRawTag();
				var header:SWFRecordHeader = data.readTagHeader();
				var tag:ITag = SWFTagFactory.create(header.type);
				tag.raw = raw;
				tag.parse(data, header.length, version);
				tags.push(tag);
				if (header.type == 0) {
					break;
				}
			}
			trace((getTimer() - t) + " ms");
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
			for (var i:uint = 0; i < tags.length; i++) {
				try {
					tags[i].publish(data, version);
				}
				catch (e:Error) {
					var tag:ITag = tags[i];
					if (tag.raw != null) {
						data.writeTagHeader(tag.type, tag.raw.length);
						data.writeBytes(tag.raw);
					} else {
						throw(e);
					}
				}
			}
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
			var str:String = "[SWF] " +
				"Version: " + version + ", " +
				"FileLength: " + fileLength + ", " +
				"FileLengthCompressed: " + fileLengthCompressed + ", " +
				"FrameSize: " + frameSize.toStringSize() + ", " +
				"FrameRate: " + frameRate + ", " +
				"FrameCount: " + frameCount + ", " +
				"Tags: " + tags.length;
			if (tags.length > 0) {
				str += "\n  Tags:"
				for (var i:uint = 0; i < Math.min(100000, tags.length); i++) {
					str += "\n" + tags[i].toString(4);
				}
			}
			return str;
		}
	}
}
