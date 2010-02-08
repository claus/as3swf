package com.codeazur.as3swf
{
	public class SWFFrameObject
	{
		public var depth:uint;
		public var characterId:uint;
		public var placedAtIndex:uint;
		public var modifiedAtIndex:uint;
		
		public function SWFFrameObject(depth:uint, characterId:uint, placedAtIndex:uint, modifiedAtIndex:uint = 0)
		{
			this.depth = depth;
			this.characterId = characterId;
			this.placedAtIndex = placedAtIndex;
			this.modifiedAtIndex = modifiedAtIndex;
		}
		
		public function clone():SWFFrameObject {
			return new SWFFrameObject(depth, characterId, placedAtIndex, modifiedAtIndex);
		}
		
		public function toString(indent:uint = 0):String {
			return "";
		}
	}
}