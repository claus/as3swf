package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.ISWFDataInput;
	import com.codeazur.utils.StringUtils;
	
	import flash.utils.ByteArray;
	
	public class TagDefineSound extends Tag implements ITag
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
		
		public function get soundData():ByteArray { return _soundData; }
		
		public function parse(data:ISWFDataInput, length:uint):void {
			soundId = data.readUI16();
			soundFormat = data.readUB(4);
			soundRate = data.readUB(2);
			soundSize = data.readUB(1);
			soundType = data.readUB(1);
			soundSampleCount = data.readUI32();
			data.readBytes(_soundData, 0, length - 7);
		}
		
		public function toString(indent:uint = 0):String {
			var str:String = StringUtils.repeat(indent) + "[" + StringUtils.printf("%02d", TYPE) + ":TagDefineSound] " +
				"SoundID: " + soundId + ", " +
				"Format: " + soundFormat + ", " +
				"Rate: ";
			switch(soundRate) {
				case SOUNDRATE_5_5: str += "5.5kHz, "; break;
				case SOUNDRATE_11: str += "11kHz, "; break;
				case SOUNDRATE_22: str += "22kHz, "; break;
				case SOUNDRATE_44: str += "44kHz, "; break;
			}
			str += "Size: " + ((soundSize == SOUNDSIZE_8) ? "8" : "16") + "bit, ";
			str += "Type: " + ((soundType == SOUNDTYPE_MONO) ? "mono" : "stereo") + ", ";
			str += "Samples: " + soundSampleCount;
			return str;
		}
	}
}
