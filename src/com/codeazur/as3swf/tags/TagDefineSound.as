package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.data.etc.MPEGFrame;
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.consts.SoundCompression;
	import com.codeazur.as3swf.data.consts.SoundRate;
	import com.codeazur.as3swf.data.consts.SoundSize;
	import com.codeazur.as3swf.data.consts.SoundType;
	
	import flash.utils.ByteArray;
	
	public class TagDefineSound extends Tag implements ITag
	{
		public static const TYPE:uint = 14;
		
		public var soundId:uint;
		public var soundFormat:uint;
		public var soundRate:uint;
		public var soundSize:uint;
		public var soundType:uint;
		public var soundSampleCount:uint;

		protected var _soundData:ByteArray;
		
		public function TagDefineSound() {
			_soundData = new ByteArray();
		}
		
		public static function create(id:uint, format:uint = SoundCompression.MP3, rate:uint = SoundRate.KHZ_44, size:uint = SoundSize.BIT_16, type:uint = SoundType.STEREO, sampleCount:uint = 0, aSoundData:ByteArray = null):TagDefineSound {
			var defineSound:TagDefineSound = new TagDefineSound();
			defineSound.soundId = id;
			defineSound.soundFormat = format;
			defineSound.soundRate = rate;
			defineSound.soundSize = size;
			defineSound.soundType = type;
			defineSound.soundSampleCount = sampleCount;
			if (aSoundData != null && aSoundData.length > 0) {
				defineSound.soundData.writeBytes(aSoundData);
			}
			return defineSound;
		}
		
		public static function createWithMP3(id:uint, mp3:ByteArray):TagDefineSound {
			if (mp3 != null && mp3.length > 0) {
				var defineSound:TagDefineSound = new TagDefineSound();
				defineSound.soundId = id;
				defineSound.processMP3(mp3);
				return defineSound;
			} else {
				throw(new Error("No MP3 data."));
			}
		}
		
		public function get soundData():ByteArray { return _soundData; }
		
		public function parse(data:SWFData, length:uint, version:uint):void {
			soundId = data.readUI16();
			soundFormat = data.readUB(4);
			soundRate = data.readUB(2);
			soundSize = data.readUB(1);
			soundType = data.readUB(1);
			soundSampleCount = data.readUI32();
			data.readBytes(_soundData, 0, length - 7);
		}
		
		public function publish(data:SWFData, version:uint):void {
			var body:SWFData = new SWFData();
			body.writeUI16(soundId);
			body.writeUB(4, soundFormat);
			body.writeUB(2, soundRate);
			body.writeUB(1, soundSize);
			body.writeUB(1, soundType);
			body.writeUI32(soundSampleCount);
			if (_soundData.length > 0) {
				body.writeBytes(_soundData);
			}
			data.writeTagHeader(type, body.length);
			data.writeBytes(body);
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "DefineSound"; }
		
		public function toString(indent:uint = 0):String {
			var str:String = toStringMain(indent) +
				"SoundID: " + soundId + ", " +
				"Format: " + soundFormat + ", " +
				"Rate: " + SoundRate.toString(soundRate) + ", " +
				"Size: " + SoundSize.toString(soundSize) + ", " +
				"Type: " + SoundType.toString(soundType) + ", " +
				"Samples: " + soundSampleCount;
			return str;
		}
		
		internal function processMP3(mp3:ByteArray):void {
			var i:uint = 0;
			var beginIdx:uint = 0;
			var endIdx:uint = mp3.length;
			var samples:uint = 0;
			var firstFrame:Boolean = true;
			var bitrate:uint = 0;
			var samplingrate:uint = 0;
			var channelmode:uint = 0;
			var frame:MPEGFrame = new MPEGFrame();
			var state:String = "id3v2";
			while (i < mp3.length) {
				switch(state) {
					case "id3v2":
						if (mp3[i] == 0x49 && mp3[i + 1] == 0x44 && mp3[i + 2] == 0x33) {
							i += 10 + ((mp3[i + 6] << 21)
								| (mp3[i + 7] << 14)
								| (mp3[i + 8] << 7)
								| mp3[i + 9]);
						}
						beginIdx = i;
						state = "sync";
						break;
					case "sync":
						if (mp3[i] == 0xff && (mp3[i + 1] & 0xe0) == 0xe0) {
							state = "frame";
						} else if (mp3[i] == 0x54 && mp3[i + 1] == 0x41 && mp3[i + 2] == 0x47) {
							endIdx = i;
							i = mp3.length;
						} else {
							i++;
						}
						break;
					case "frame":
						frame.setHeaderByteAt(0, mp3[i++]);
						frame.setHeaderByteAt(1, mp3[i++]);
						frame.setHeaderByteAt(2, mp3[i++]);
						frame.setHeaderByteAt(3, mp3[i++]);
						if (frame.hasCRC) {
							frame.setCRCByteAt(0, mp3[i++]);
							frame.setCRCByteAt(1, mp3[i++]);
						}
						if (firstFrame) {
							samplingrate = frame.samplingrate;
							bitrate = frame.bitrate;
							channelmode = frame.channelMode;
							firstFrame = false;
						} else {
							if (bitrate != frame.bitrate) {
								throw(new Error("This mp3 is encoded with variable bitrates. VBR is not allowed. Please use CBR mp3s."));
							}
						}
						samples += frame.samples;
						i += frame.size;
						state = "sync";
						break;
				}
			}
			soundSampleCount = samples;
			soundFormat = SoundCompression.MP3;
			soundSize = SoundSize.BIT_16;
			soundType = (channelmode == MPEGFrame.CHANNEL_MODE_MONO) ? SoundType.MONO : SoundType.STEREO;
			switch(samplingrate) {
				case 44100: soundRate = SoundRate.KHZ_44; break;
				case 22050: soundRate = SoundRate.KHZ_22; break;
				case 11025: soundRate = SoundRate.KHZ_11; break;
				default: throw(new Error("Unsupported sampling rate: " + samplingrate + " Hz"));
			}
			// Clear ByteArray
			soundData.length = 0;
			// Write SeekSamples (here always 0)
			soundData.writeShort(0);
			// Write raw MP3 (without ID3 metadata)
			soundData.writeBytes(mp3, beginIdx, endIdx - beginIdx);
		}
	}
}
