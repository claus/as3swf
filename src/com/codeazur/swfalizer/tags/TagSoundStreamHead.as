package com.codeazur.swfalizer.tags
{
	import com.codeazur.swfalizer.ISWFDataInput;
	import com.codeazur.utils.StringUtils;
	
	public class TagSoundStreamHead extends Tag implements ITag
	{
		public static const SOUNDRATE_5_5:uint = 0;
		public static const SOUNDRATE_11:uint = 1;
		public static const SOUNDRATE_22:uint = 2;
		public static const SOUNDRATE_44:uint = 3;
		public static const SOUNDSIZE_8:uint = 0;
		public static const SOUNDSIZE_16:uint = 1;
		public static const SOUNDTYPE_MONO:uint = 0;
		public static const SOUNDTYPE_STEREO:uint = 1;
		public static const SOUNDCOMPRESSION_ADPCM:uint = 1;
		public static const SOUNDCOMPRESSION_MP3:uint = 2;

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
			if (streamSoundCompression == SOUNDCOMPRESSION_MP3) {
				latencySeek = data.readSI16();
			}
		}
		
		public function toString(indent:uint = 0):String {
			var str:String = StringUtils.repeat(indent) + "[" + StringUtils.printf("%02d", TYPE) + ":TagSoundStreamHead] ";
			str += "Playback: (";
			switch(playbackSoundRate) {
				case SOUNDRATE_5_5: str += "5.5kHz,"; break;
				case SOUNDRATE_11: str += "11kHz,"; break;
				case SOUNDRATE_22: str += "22kHz,"; break;
				case SOUNDRATE_44: str += "44kHz,"; break;
			}
			str += ((playbackSoundSize == SOUNDSIZE_8) ? "8" : "16") + "bit,";
			str += ((playbackSoundType == SOUNDTYPE_MONO) ? "mono" : "stereo") + "), ";
			str += "Streaming: (";
			switch(streamSoundCompression) {
				case SOUNDCOMPRESSION_ADPCM: str += "ADPCM,"; break;
				case SOUNDCOMPRESSION_MP3: str += "MP3,"; break;
			}
			switch(streamSoundRate) {
				case SOUNDRATE_5_5: str += "5.5kHz,"; break;
				case SOUNDRATE_11: str += "11kHz,"; break;
				case SOUNDRATE_22: str += "22kHz,"; break;
				case SOUNDRATE_44: str += "44kHz,"; break;
			}
			str += ((streamSoundSize == SOUNDSIZE_8) ? "8" : "16") + "bit,";
			str += ((streamSoundType == SOUNDTYPE_MONO) ? "mono" : "stereo") + "), ";
			str += "Samples: " + streamSoundSampleCount;
			return str;
		}
	}
}
