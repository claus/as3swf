package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
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
			throw(new Error("TODO: implement publish()"));
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "DefineSound"; }
		
		public function toString(indent:uint = 0):String {
			var str:String = toStringMain(indent) +
				"SoundID: " + soundId + ", " +
				"Format: " + soundFormat + ", " +
				"Rate: " + SoundRate.toString(soundRate) + ", " +
				"Size: " + SoundSize.toString(soundSize) + ", ";
				"Type: " + SoundType.toString(soundType) + ", ";
				"Samples: " + soundSampleCount;
			return str;
		}
	}
}
