package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.ISWFDataInput;
	import com.codeazur.utils.StringUtils;
	
	public class TagSoundStreamHead2 extends TagSoundStreamHead implements ITag
	{
		public static const TYPE:uint = 45;
		
		public function TagSoundStreamHead2() {}
		
		override public function toString(indent:uint = 0):String {
			var str:String = StringUtils.repeat(indent) + "[" + StringUtils.printf("%02d", TYPE) + ":TagSoundStreamHead2] ";
			str += "Playback: (";
			switch(playbackSoundRate) {
				case TagSoundStreamHead.SOUNDRATE_5_5: str += "5.5kHz,"; break;
				case TagSoundStreamHead.SOUNDRATE_11: str += "11kHz,"; break;
				case TagSoundStreamHead.SOUNDRATE_22: str += "22kHz,"; break;
				case TagSoundStreamHead.SOUNDRATE_44: str += "44kHz,"; break;
			}
			str += ((playbackSoundSize == TagSoundStreamHead.SOUNDSIZE_8) ? "8" : "16") + "bit,";
			str += ((playbackSoundType == TagSoundStreamHead.SOUNDTYPE_MONO) ? "mono" : "stereo") + "), ";
			str += "Streaming: (";
			switch(streamSoundCompression) {
				case TagSoundStreamHead.SOUNDCOMPRESSION_ADPCM: str += "ADPCM,"; break;
				case TagSoundStreamHead.SOUNDCOMPRESSION_MP3: str += "MP3,"; break;
			}
			switch(streamSoundRate) {
				case TagSoundStreamHead.SOUNDRATE_5_5: str += "5.5kHz,"; break;
				case TagSoundStreamHead.SOUNDRATE_11: str += "11kHz,"; break;
				case TagSoundStreamHead.SOUNDRATE_22: str += "22kHz,"; break;
				case TagSoundStreamHead.SOUNDRATE_44: str += "44kHz,"; break;
			}
			str += ((streamSoundSize == TagSoundStreamHead.SOUNDSIZE_8) ? "8" : "16") + "bit,";
			str += ((streamSoundType == STagSoundStreamHead.OUNDTYPE_MONO) ? "mono" : "stereo") + "), ";
			str += "Samples: " + streamSoundSampleCount;
			return str;
		}
	}
}
