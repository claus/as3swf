package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	
	public class TagSetTabIndex extends Tag implements ITag
	{
		public static const TYPE:uint = 66;
		
		public var depth:uint;
		public var tabIndex:uint;
		
		public function TagSetTabIndex() {}
		
		public function parse(data:SWFData, length:uint):void {
			cache(data, length);
			depth = data.readUI16();
			tabIndex = data.readUI16();
		}
		
		override public function publish(data:SWFData):void {
			data.writeTagHeader(type, 4);
			data.writeUI16(depth);
			data.writeUI16(tabIndex);
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "SetTabIndex"; }
		override public function get version():uint { return 7; }
		
		public function toString(indent:uint = 0):String {
			return toStringMain(indent) +
				"Depth: " + depth + ", " +
				"TabIndex: " + tabIndex;
		}
	}
}
