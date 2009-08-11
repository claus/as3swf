package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.SWFRecordHeader;
	import com.codeazur.as3swf.data.SWFRectangle;
	import com.codeazur.as3swf.factories.SWFTagFactory;
	import com.codeazur.utils.StringUtils;
	
	import flash.utils.ByteArray;
	
	public class TagDefineSprite extends Tag implements ITag
	{
		public static const TYPE:uint = 39;
		
		protected var spriteId:uint;
		protected var frameCount:uint;
		
		protected var _controlTags:Vector.<ITag>;
		
		public function TagDefineSprite() {
			_controlTags = new Vector.<ITag>();
		}
		
		public function get controlTags():Vector.<ITag> { return _controlTags; }
		
		public function parse(data:SWFData, length:uint, version:uint):void {
			spriteId = data.readUI16();
			frameCount = data.readUI16();
			_controlTags.length = 0;
			while (true) {
				var raw:ByteArray = data.readRawTag();
				var header:SWFRecordHeader = data.readTagHeader();
				var tag:ITag = SWFTagFactory.create(header.type);
				tag.raw = raw;
				tag.parse(data, header.length, version);
				_controlTags.push(tag);
				if (header.type == 0) {
					break;
				}
			}
		}
		
		public function publish(data:SWFData, version:uint):void {
			var body:SWFData = new SWFData();
			body.writeUI16(spriteId);
			body.writeUI16(frameCount); // TODO: get the real number of frames from controlTags
			for (var i:uint = 0; i < _controlTags.length; i++) {
				try {
					_controlTags[i].publish(body, version);
				}
				catch (e:Error) {
					var tag:ITag = _controlTags[i];
					if (tag.raw != null) {
						body.writeTagHeader(tag.type, tag.raw.length);
						body.writeBytes(tag.raw);
					} else {
						throw(e);
					}
				}
			}
			data.writeTagHeader(type, body.length);
			data.writeBytes(body);
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "DefineSprite"; }
		override public function get version():uint { return 3; }
		
		public function toString(indent:uint = 0):String {
			var str:String = toStringMain(indent) +
				"ID: " + spriteId + ", " +
				"FrameCount: " + frameCount + ", " +
				"Tags: " + _controlTags.length;
			if (_controlTags.length > 0) {
				str += "\n" + StringUtils.repeat(indent + 2) + "ControlTags:"
				for (var i:uint = 0; i < _controlTags.length; i++) {
					str += "\n" + _controlTags[i].toString(indent + 4);
				}
			}
			return str;
		}
	}
}
