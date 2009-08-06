package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	
	public class TagRemoveObject extends Tag implements ITag
	{
		public static const TYPE:uint = 5;
		
		public var characterId:uint;
		public var depth:uint;
		
		public function TagRemoveObject() {}
		
		public function parse(data:SWFData, length:uint):void {
			characterId = data.readUI16();
			depth = data.readUI16();
		}
		
		public function publish(data:SWFData):void {
			throw(new Error("TODO: implement publish()"));
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "RemoveObject"; }
		
		public function toString(indent:uint = 0):String {
			return toStringMain(indent) +
				"CharacterID: " + characterId + ", " +
				"Depth: " + depth;
		}
	}
}
