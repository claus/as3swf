package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	
	import flash.utils.ByteArray;
	
	public class TagDefineBits extends Tag implements ITag
	{
		public static const TYPE:uint = 6;
		
		public var characterId:uint;

		protected var _bitmapData:ByteArray;
		
		public function TagDefineBits() {
			_bitmapData = new ByteArray();
		}
		
		public function get bitmapData():ByteArray { return _bitmapData; }
		
		public function parse(data:SWFData, length:uint):void {
			characterId = data.readUI16();
			if (length > 2) {
				data.readBytes(_bitmapData, 0, length - 2);
			}
		}
		
		public function publish(data:SWFData):void {
			data.writeTagHeader(type, _bitmapData.length + 2);
			data.writeUI16(characterId);
			data.writeBytes(_bitmapData, 0, _bitmapData.length);
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "DefineBits"; }
		override public function get version():uint { return 1; }
		
		public function toString(indent:uint = 0):String {
			return toStringMain(indent) +
				"ID: " + characterId;
		}
	}
}
