package com.codeazur.as3swf.timeline
{
	import com.codeazur.utils.StringUtils;

	public class FrameObject
	{
		// The depth of this display object
		public var depth:uint;
		// The character id of this display object
		public var characterId:uint;
		// The tag index of the PlaceObject tag that placed this object on the display list
		public var placedAtIndex:uint;
		// The tag index of the PlaceObject tag that modified this object (optional)
		public var lastModifiedAtIndex:uint;

		// Whether this is a keyframe or not
		public var isKeyframe:Boolean;
		// The index of the layer this object resides on 
		public var layer:int = -1;
		
		public function FrameObject(depth:uint, characterId:uint, placedAtIndex:uint, lastModifiedAtIndex:uint = 0, isKeyframe:Boolean = false)
		{
			this.depth = depth;
			this.characterId = characterId;
			this.placedAtIndex = placedAtIndex;
			this.lastModifiedAtIndex = lastModifiedAtIndex;
			this.isKeyframe = isKeyframe;
			this.layer = -1;
		}
		
		public function clone():FrameObject {
			return new FrameObject(depth, characterId, placedAtIndex, lastModifiedAtIndex, false);
		}
		
		public function toString(indent:uint = 0):String {
			var str:String = "\n" + StringUtils.repeat(indent + 2) +
				"Depth: " + depth + (layer > -1 ? " (Layer " + layer + ")" : "") + ", " +
				"CharacterId: " + characterId + ", " +
				"PlacedAt: "  + placedAtIndex;
			if(lastModifiedAtIndex) {
				str += ", LastModifiedAt: " + lastModifiedAtIndex;
			}
			if(isKeyframe) {
				str += ", IsKeyframe";
			}
			return str;
		}
	}
}