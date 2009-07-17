package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.ISWFDataInput;
	import com.codeazur.as3swf.data.consts.SoundRate;
	import com.codeazur.as3swf.data.consts.SoundSize;
	import com.codeazur.as3swf.data.consts.SoundType;
	import com.codeazur.as3swf.data.consts.SoundCompression;
	import com.codeazur.utils.StringUtils;
	
	public class TagSoundStreamHead extends Tag implements ITag
	{
		public static const TYPE:uint = 18;
		
		public var playbackSoundRate:uint;
		public var playbackSoundSize:uint;
		public var playbackSoundType:uint;
		public var streamSoundCompression:uint;
		public var streamSoundRate:uint;
		public var streamSoundSize:uint;
		public var streamSoundType:uint;
		public var streamSoundSampleCount:uint;
		public var latencySeek:uint;
		
		public function TagSoundStreamHead() {}
		
		public function parse(data:ISWFDataInput, length:uint):void {
			data.readUB(4);
			playbackSoundRate = data.readUB(2);
			playbackSoundSize = data.readUB(1);
			playbackSoundType = data.readUB(1);
			streamSoundCompression = data.readUB(4);
			streamSoundRate = data.readUB(2);
			streamSoundSize = data.readUB(1);
			streamSoundType = data.readUB(1);
			streamSoundSampleCount = data.readUI16();
			if (streamSoundCompression == SoundCompression.MP3) {
				latencySeek = data.readSI16();
			}
		}
		
		public function toString(indent:uint = 0):String {
			var str:String = StringUtils.repeat(indent) + "[" + StringUtils.printf("%02d", TYPE) + ":TagSoundStreamHead] ";
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
