package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWF;
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.SWFTimeline;
	import com.codeazur.as3swf.tags.IDefinitionTag;
	import com.codeazur.as3swf.timeline.Frame;
	import com.codeazur.as3swf.timeline.Layer;
	import com.codeazur.as3swf.timeline.Scene;
	
	import flash.utils.Dictionary;
	
	public class TagDefineSprite implements IDefinitionTag
	{
		public static const TYPE:uint = 39;
		
		public var frameCount:uint;
		
		protected var _characterId:uint;
		protected var _timeline:SWFTimeline;
		
		public function TagDefineSprite(swf:SWF) {
			_timeline = swf.createTimeline();
		}
		
		public function get characterId():uint { return _characterId; }
		public function get timeline():SWFTimeline { return _timeline; }
		
		public function get tags():Vector.<ITag> { return timeline.tags; }
		public function get dictionary():Dictionary { return timeline.dictionary; }
		public function get scenes():Vector.<Scene> { return timeline.scenes; }
		public function get frames():Vector.<Frame> { return timeline.frames; }
		public function get layers():Vector.<Layer> { return timeline.layers; }
		
		public function parse(data:SWFData, length:uint, version:uint):void {
			_characterId = data.readUI16();
			frameCount = data.readUI16();
			timeline.parse(data, version);
		}
		
		public function publish(data:SWFData, version:uint):void {
			var body:SWFData = new SWFData();
			body.writeUI16(characterId);
			body.writeUI16(frameCount); // TODO: get the real number of frames from controlTags
			timeline.publish(body, version);
			data.writeTagHeader(type, body.length);
			data.writeBytes(body);
		}
		
		public function get type():uint { return TYPE; }
		public function get name():String { return "DefineSprite"; }
		public function get version():uint { return 3; }
		public function get level():uint { return 1; }
	
		public function toString(indent:uint = 0):String {
			return Tag.toStringCommon(type, name, indent) +
				"ID: " + characterId + ", " +
				"FrameCount: " + frameCount +
				timeline.toString(indent);
		}
	}
}
