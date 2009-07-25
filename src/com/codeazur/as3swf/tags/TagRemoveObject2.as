package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	
	public class TagRemoveObject2 extends Tag implements ITag
	{
		public static const TYPE:uint = 28;
		
		public var depth:uint;
		
		public function TagRemoveObject2() {}
		
		public function parse(data:SWFData, length:uint):void {
			cache(data, length);
			depth = data.readUI16();
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "RemoveObject2"; }
		
		public function toString(indent:uint = 0):String {
			return toStringMain(indent) +
				"Depth: " + depth;
		}
	}
}
