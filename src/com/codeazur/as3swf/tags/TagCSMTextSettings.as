package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	
	public class TagCSMTextSettings extends Tag implements ITag
	{
		public static const TYPE:uint = 74;
		
		public var textId:uint;
		public var useFlashType:uint;
		public var gridFit:uint;
		public var thickness:Number;
		public var sharpness:Number;
		
		public function TagCSMTextSettings() {}
		
		public function parse(data:SWFData, length:uint, version:uint):void {
			textId = data.readUI16();
			useFlashType = data.readUB(2);
			gridFit = data.readUB(3);
			data.readUB(3); // reserved, always 0
			thickness = data.readFIXED();
			sharpness = data.readFIXED();
			data.readUI8(); // reserved, always 0
		}
		
		public function publish(data:SWFData, version:uint):void {
			data.writeTagHeader(type, 12);
			data.writeUI16(textId);
			data.writeUB(2, useFlashType);
			data.writeUB(3, gridFit);
			data.writeUB(3, 0); // reserved, always 0
			data.writeFIXED(thickness);
			data.writeFIXED(sharpness);
			data.writeUI8(0); // reserved, always 0
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "CSMTextSettings"; }
		override public function get version():uint { return 8; }
		
		public function toString(indent:uint = 0):String {
			return toStringMain(indent) +
				"TextID: " + textId + ", " +
				"UseFlashType: " + useFlashType + ", " +
				"GridFit: " + gridFit + ", " +
				"Thickness: " + thickness + ", " +
				"Sharpness: " + sharpness;
		}
	}
}
