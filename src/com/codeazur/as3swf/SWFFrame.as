package com.codeazur.as3swf
{
	import com.codeazur.utils.StringUtils;
	
	import flash.utils.Dictionary;

	public class SWFFrame
	{
		public var frameNumber:uint = 0;
		public var tagIndexStart:uint = 0;
		public var tagIndexEnd:uint = 0;
		
		protected var _objects:Dictionary;
		
		public function SWFFrame(frameNumber:uint = 0, tagIndexStart:uint = 0)
		{
			this.frameNumber = frameNumber;
			this.tagIndexStart = tagIndexStart;
			_objects = new Dictionary();
		}
		
		public function get objects():Dictionary { return _objects; }
		
		public function get tagCount():uint {
			return tagIndexEnd - tagIndexStart + 1;
		}
		
		public function placeObject(tagIndex:uint, depth:uint, characterId:uint = 0):void {
			var frameObject:SWFFrameObject = _objects[depth] as SWFFrameObject; 
			if(frameObject) {
				if(characterId == 0) {
					frameObject.modifiedAtIndex = tagIndex;
				} else if(frameObject.characterId != characterId) {
					frameObject.modifiedAtIndex = tagIndex;
					frameObject.characterId = characterId;
				}
			} else {
				_objects[depth] = new SWFFrameObject(depth, characterId, tagIndex);
			}
		}
		
		public function removeObject(depth:uint, characterId:uint):void {
			delete _objects[depth];
		}
		
		public function clone():SWFFrame {
			var frame:SWFFrame = new SWFFrame();
			for(var depth:String in _objects) {
				frame._objects[depth] = SWFFrameObject(_objects[depth]).clone();
			}
			return frame;
		}
		
		public function toString(indent:uint = 0):String {
			var str:String = StringUtils.repeat(indent) + "[" + frameNumber + "] " +
				"Start: " + tagIndexStart + ", " +
				"Length: " + tagCount;
			var strobj:String = "";
			for(var depth:String in _objects) {
				strobj += SWFFrameObject(_objects[depth]).toString(indent);
			}
			return str + strobj;
		}
	}
}