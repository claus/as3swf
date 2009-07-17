package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.ISWFDataInput;
	import com.codeazur.as3swf.data.consts.SoundRate;
	import com.codeazur.as3swf.data.consts.SoundSize;
	import com.codeazur.as3swf.data.consts.SoundType;
	import com.codeazur.as3swf.data.consts.SoundCompression;
	import com.codeazur.utils.StringUtils;
	
	public class TagSoundStreamHead2 extends TagSoundStreamHead implements ITag
	{
		public static const TYPE:uint = 45;
		
		public function TagSoundStreamHead2() {}
		
		override public function toString(indent:uint = 0):String {
			var str:String = StringUtils.repeat(indent) + "[" + StringUtils.printf("%02d", TYPE) + ":TagSoundStreamHead2] ";
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
