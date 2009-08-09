package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.SWFRectangle;
	
	public class TagDefineScalingGrid extends Tag implements ITag
	{
		public static const TYPE:uint = 78;
		
		public var characterId:uint;
		public var splitter:SWFRectangle;
		
		public function TagDefineScalingGrid() {}
		
		public function parse(data:SWFData, length:uint, version:uint):void {
			characterId = data.readUI16();
			splitter = data.readRECT();
		}
		
		public function publish(data:SWFData, version:uint):void {
			throw(new Error("TODO: implement publish()"));
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "DefineScalingGrid"; }
		
		public function toString(indent:uint = 0):String {
			return toStringMain(indent) +
				"CharacterID: " + characterId + ", " +
				"Splitter: " + splitter;
		}
	}
}
