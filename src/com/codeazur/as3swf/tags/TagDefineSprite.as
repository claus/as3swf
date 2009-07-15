package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.ISWFDataInput;
	import com.codeazur.as3swf.data.SWFRecordHeader;
	import com.codeazur.as3swf.data.SWFRectangle;
	import com.codeazur.as3swf.data.SWFShapeWithStyle;
	import com.codeazur.as3swf.factories.SWFTagFactory;
	import com.codeazur.utils.StringUtils;
	
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
		
		public function parse(data:ISWFDataInput, length:uint):void {
			spriteId = data.readUI16();
			frameCount = data.readUI16();
			while (true) {
				var header:SWFRecordHeader = Tag.parseHeader(data);
				var tag:ITag = SWFTagFactory.create(header.type);
				tag.parse(data, header.length);
				_controlTags.push(tag);
				if (header.type == 0) {
					break;
				}
			}
		}
		
		public function toString(indent:uint = 0):String {
			var str:String = StringUtils.repeat(indent) + "[" + StringUtils.printf("%02d", TYPE) + ":TagDefineSprite] " +
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
