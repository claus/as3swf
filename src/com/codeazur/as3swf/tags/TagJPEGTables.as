package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	
	import flash.utils.ByteArray;
	
	public class TagJPEGTables extends Tag implements ITag
	{
		public static const TYPE:uint = 8;
		
		protected var _jpegTables:ByteArray;
		
		public function TagJPEGTables() {
			_jpegTables = new ByteArray();
		}
		
		public function get jpegTables():ByteArray { return _jpegTables; }
		
		public function parse(data:SWFData, length:uint, version:uint):void {
			if(length > 0) {
				data.readBytes(_jpegTables, 0, length);
			}
		}
		
		public function publish(data:SWFData, version:uint):void {
			var body :SWFData = new SWFData();
			
			if(_jpegTables && _jpegTables.length) {
				_jpegTables.readBytes(data, 0, _jpegTables.length);
			}
			
			data.writeTagHeader(type, body.length);
			data.writeBytes(body);
			//throw(new Error("TODO: implement "+ this.name + "#publish()"));
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "JPEGTables"; }
		
		public function toString(indent:uint = 0):String {
			return toStringMain(indent) + " Length: " + _jpegTables.length;
		}
	}
}
