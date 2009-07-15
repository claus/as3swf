package com.codeazur.as3swf
{
	import com.codeazur.as3swf.ISWFDataInput;
	import com.codeazur.as3swf.data.SWFRecordHeader;
	import com.codeazur.as3swf.data.SWFRectangle;
	import com.codeazur.as3swf.factories.SWFTagFactory;
	import com.codeazur.as3swf.tags.ITag;
	import com.codeazur.as3swf.tags.Tag;

	import flash.utils.getTimer;
	
	public class SWF
	{
		public var version:int;
		public var fileLength:uint;
		public var frameSize:SWFRectangle;
		public var frameRate:Number;
		public var frameCount:uint;
		
		protected var _tags:Vector.<ITag>;

		public function SWF() {
			_tags = new Vector.<ITag>();
		}
		
		public function get tags():Vector.<ITag> { return _tags; }
		
		public function parse(data:ISWFDataInput):void
		{
			var compressed:Boolean = false;
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
			
			if (compressed) {
				data.uncompress();
			}
			
			frameSize = data.readRECT();
			frameRate = data.readFIXED8();
			frameCount = data.readUI16();
			
			var t:uint = getTimer();
			while (true) {
				var header:SWFRecordHeader = Tag.parseHeader(data);
				var tag:ITag = SWFTagFactory.create(header.type);
				tag.parse(data, header.length);
				tags.push(tag);
				if (header.type == 0) {
					break;
				}
			}
			trace((getTimer() - t) + " ms");
		}
		
		public function toString():String {
			var str:String = "[SWF] " +
				"Version: " + version + ", " +
				"FileLength: " + fileLength + ", " +
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
