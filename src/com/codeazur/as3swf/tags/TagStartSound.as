package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.ISWFDataInput;
	import com.codeazur.as3swf.data.SWFSoundInfo;
	import com.codeazur.utils.StringUtils;
	
	import flash.utils.ByteArray;
	
	public class TagStartSound extends Tag implements ITag
	{
		public static const TYPE:uint = 15;
		
		public var soundId:uint;
		public var soundInfo:SWFSoundInfo;
		
		public function TagStartSound() {}
		
		public function parse(data:ISWFDataInput, length:uint):void {
			soundId = data.readUI16();
			soundInfo = data.readSOUNDINFO();
		}
		
		public function toString(indent:uint = 0):String {
			var str:String = StringUtils.repeat(indent) + "[" + StringUtils.printf("%02d", TYPE) + ":TagStartSound] " +
				"SoundID: " + soundId + ", " +
				"SoundInfo: " + soundInfo;
			return str;
		}
	}
}
