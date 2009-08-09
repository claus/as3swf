package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.SWFColorTransform;
	
	public class TagDefineButtonCxform extends Tag implements ITag
	{
		public static const TYPE:uint = 23;
		
		public var buttonId:uint;
		public var buttonColorTransform:SWFColorTransform;
		
		public function TagDefineButtonCxform() {}
		
		public function parse(data:SWFData, length:uint, version:uint):void {
			buttonId = data.readUI16();
			buttonColorTransform = data.readCXFORM();
		}
		
		public function publish(data:SWFData, version:uint):void {
			throw(new Error("TODO: implement publish()"));
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "DefineButtonCxform"; }
		
		public function toString(indent:uint = 0):String {
			var str:String = toStringMain(indent) +
				"ID: " + buttonId + ", " +
				"ColorTransform: " + buttonColorTransform;
			return str;
		}
	}
}
