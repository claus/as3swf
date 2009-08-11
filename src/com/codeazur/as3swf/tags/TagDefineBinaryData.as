package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	
	import flash.utils.ByteArray;
	
	public class TagDefineBinaryData extends Tag implements ITag
	{
		public static const TYPE:uint = 87;
		
		public var tagId:uint;
		
		protected var _binaryData:ByteArray;
		
		public function TagDefineBinaryData() {
			_binaryData = new ByteArray();
		}
		
		public function get binaryData():ByteArray { return _binaryData; }
		
		public function parse(data:SWFData, length:uint, version:uint):void {
			tagId = data.readUI16();
			data.readUI32(); // reserved, always 0
			if (length > 6) {
				data.readBytes(_binaryData, 0, length - 6);
			}
		}
		
		public function publish(data:SWFData, version:uint):void {
			var body:SWFData = new SWFData();
			body.writeUI16(tagId);
			body.writeUI32(0); // reserved, always 0
			if (_binaryData.length > 0) {
				body.writeBytes(_binaryData);
			}
			data.writeTagHeader(type, body.length);
			data.writeBytes(body);
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "DefineBinaryData"; }
		override public function get version():uint { return 9; }
		
		public function toString(indent:uint = 0):String {
			return toStringMain(indent);
		}
	}
}
