package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	
	public class TagRemoveObject2 extends Tag implements ITag
	{
		public static const TYPE:uint = 28;
		
		public var depth:uint;
		
		public function TagRemoveObject2() {}
		
		public function parse(data:SWFData, length:uint, version:uint):void {
			depth = data.readUI16();
		}
		
		public function publish(data:SWFData, version:uint):void {
			data.writeTagHeader(type, 2);
			data.writeUI16(depth);
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "RemoveObject2"; }
		override public function get version():uint { return 3; }
		
		public function toString(indent:uint = 0):String {
			return toStringMain(indent) +
				"Depth: " + depth;
		}
	}
}
