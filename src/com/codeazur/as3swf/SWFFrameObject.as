package com.codeazur.as3swf
{
	import com.codeazur.utils.StringUtils;

	public class SWFFrameObject
	{
		// The depth of this display object
		public var depth:uint;
		// The character id of this display object
		public var characterId:uint;
		// The tag index of the PlaceObject tag that placed this object on the display list
		public var placedAtIndex:uint;
		// The tag index of the PlaceObject tag that modified this object (optional, only for tweens)
		public var lastModifiedAtIndex:uint;
		
		public function SWFFrameObject(depth:uint, characterId:uint, placedAtIndex:uint, lastModifiedAtIndex:uint = 0)
		{
			this.depth = depth;
			this.characterId = characterId;
			this.placedAtIndex = placedAtIndex;
			this.lastModifiedAtIndex = lastModifiedAtIndex;
		}
		
		public function clone():SWFFrameObject {
			return new SWFFrameObject(depth, characterId, placedAtIndex, lastModifiedAtIndex);
		}
		
		public function toString(indent:uint = 0):String {
			var str:String = "\n" + StringUtils.repeat(indent + 2) +
				"Depth: " + depth + ", " +
				"CharacterId: " + characterId + ", " +
				"PlacedAt: "  + placedAtIndex;
			if(lastModifiedAtIndex) {
				str += ", LastModifiedAt: " + lastModifiedAtIndex;
			}
			return str;
		}
	}
}