package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.SWFTimeline;
	
	public class TagDefineSprite extends Tag implements IDefinitionTag
	{
		public static const TYPE:uint = 39;
		
		public var frameCount:uint;
		
		protected var _characterId:uint;
		protected var _timeline:SWFTimeline;
		
		public function TagDefineSprite() {
			_timeline = new SWFTimeline();
		}
		
		public function get characterId():uint { return _characterId; }
		public function get timeline():SWFTimeline { return _timeline; }
		
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
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "DefineSprite"; }
		override public function get version():uint { return 3; }
		
		public function toString(indent:uint = 0):String {
			return toStringMain(indent) +
				"ID: " + characterId + ", " +
				"FrameCount: " + frameCount +
				timeline.toString(indent);
		}
	}
}
