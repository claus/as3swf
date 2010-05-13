package com.codeazur.as3swf.timeline
{
	import com.codeazur.utils.StringUtils;
	
	import flash.utils.Dictionary;

	public class Frame
	{
		public var frameNumber:uint = 0;
		public var tagIndexStart:uint = 0;
		public var tagIndexEnd:uint = 0;
		public var label:String;
		
		protected var _objects:Dictionary;
		protected var _characters:Array;
		
		public function Frame(frameNumber:uint = 0, tagIndexStart:uint = 0)
		{
			this.frameNumber = frameNumber;
			this.tagIndexStart = tagIndexStart;
			_objects = new Dictionary();
			_characters = [];
		}
		
		public function get objects():Dictionary { return _objects; }
		public function get characters():Array { return _characters; }
		
		public function get tagCount():uint {
			return tagIndexEnd - tagIndexStart + 1;
		}
		
		public function placeObject(tagIndex:uint, depth:uint, characterId:uint = 0):void {
			var frameObject:FrameObject = _objects[depth] as FrameObject; 
			if(frameObject) {
				// A character is already available at the specified depth
				if(characterId == 0) {
					// The PlaceObject tag has no character id defined:
					// This means that the previous character is reused 
					// and most likely modified by transforms
					frameObject.lastModifiedAtIndex = tagIndex;
					frameObject.isKeyframe = false;
				} else {					
					// A character id is defined:
					// This means that the previous character is replaced 
					// (possible transforms defined in previous frames are discarded)
					frameObject.lastModifiedAtIndex = 0;
					frameObject.placedAtIndex = tagIndex;
					frameObject.isKeyframe = true;
					if(characterId != frameObject.characterId) {
						// The character id does not match the previous character:
						// An entirely new character is placed at this depth.
						frameObject.characterId = characterId;
					}
				}
			} else {
				// No character defined at specified depth. Create one.
				_objects[depth] = new FrameObject(depth, characterId, tagIndex, 0, true);
			}
		}
		
		public function removeObject(depth:uint, characterId:uint):void {
			delete _objects[depth];
		}
		
		public function clone():Frame {
			var frame:Frame = new Frame();
			for(var depth:String in _objects) {
				frame._objects[depth] = FrameObject(_objects[depth]).clone();
			}
			return frame;
		}
		
		public function toString(indent:uint = 0):String {
			var str:String = StringUtils.repeat(indent) + "[" + frameNumber + "] " +
				"Start: " + tagIndexStart + ", " +
				"Length: " + tagCount;
			if(label != null && label != "") { str += ", Label: " + label; }
			if(characters.length > 0) {
				str += "\n" + StringUtils.repeat(indent + 2) + "Defined CharacterIDs: " + characters.join(", ");
			}
			for(var depth:String in _objects) {
				str += FrameObject(_objects[depth]).toString(indent);
			}
			return str;
		}
	}
}