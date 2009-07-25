package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.data.consts.SoundRate;
	import com.codeazur.as3swf.data.consts.SoundSize;
	import com.codeazur.as3swf.data.consts.SoundType;
	import com.codeazur.as3swf.data.consts.SoundCompression;
	
	public class TagSoundStreamHead2 extends TagSoundStreamHead implements ITag
	{
		public static const TYPE:uint = 45;
		
		public function TagSoundStreamHead2() {}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "SoundStreamHead2"; }
		
		override public function toString(indent:uint = 0):String {
			var str:String = toStringMain(indent);
			str += "Playback: (";
			str += SoundRate.toString(playbackSoundRate) + ",";
			str += SoundSize.toString(playbackSoundSize) + ",";
			str += SoundType.toString(playbackSoundType) + "), ";
			str += "Streaming: (";
			str += SoundCompression.toString(streamSoundCompression) + ",";
			str += SoundRate.toString(streamSoundRate) + ",";
			str += SoundSize.toString(streamSoundSize) + ",";
			str += SoundType.toString(streamSoundType) + "), ";
			str += "Samples: " + streamSoundSampleCount;
			return str;
		}
	}
}
