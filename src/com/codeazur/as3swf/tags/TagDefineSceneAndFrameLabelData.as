package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.SWFFrameLabel;
	import com.codeazur.as3swf.data.SWFScene;
	import com.codeazur.utils.StringUtils;
	
	public class TagDefineSceneAndFrameLabelData extends Tag implements ITag
	{
		public static const TYPE:uint = 86;
		
		protected var _scenes:Vector.<SWFScene>;
		protected var _frameLabels:Vector.<SWFFrameLabel>;
		
		public function TagDefineSceneAndFrameLabelData() {
			_scenes = new Vector.<SWFScene>();
			_frameLabels = new Vector.<SWFFrameLabel>();
		}
		
		public function get scenes():Vector.<SWFScene> { return _scenes; }
		public function get frameLabels():Vector.<SWFFrameLabel> { return _frameLabels; }
		
		public function parse(data:SWFData, length:uint, version:uint):void {
			var i:uint;
			var sceneCount:uint = data.readEncodedU32();
			for (i = 0; i < sceneCount; i++) {
				var sceneOffset:uint = data.readEncodedU32();
				var sceneName:String = data.readString();
				_scenes.push(new SWFScene(sceneOffset, sceneName));
			}
			var frameLabelCount:uint = data.readEncodedU32();
			for (i = 0; i < frameLabelCount; i++) {
				var frameNumber:uint = data.readEncodedU32();
				var frameLabel:String = data.readString();
				_frameLabels.push(new SWFFrameLabel(frameNumber, frameLabel));
			}
		}

		public function publish(data:SWFData, version:uint):void {
			throw(new Error("TODO: implement publish()"));
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "DefineSceneAndFrameLabelData"; }
		
		public function toString(indent:uint = 0):String {
			var str:String = toStringMain(indent);
			var i:uint;
			if (_scenes.length > 0) {
				str += "\n" + StringUtils.repeat(indent + 2) + "Scenes:";
				for (i = 0; i < _scenes.length; i++) {
					str += "\n" + StringUtils.repeat(indent + 4) + "[" + i + "] " + _scenes[i].toString();
				}
			}
			if (_frameLabels.length > 0) {
				str += "\n" + StringUtils.repeat(indent + 2) + "FrameLabels:";
				for (i = 0; i < _frameLabels.length; i++) {
					str += "\n" + StringUtils.repeat(indent + 4) + "[" + i + "] " + _frameLabels[i].toString();
				}
			}
			return str;
		}
	}
}
