package com.codeazur.swfalizer.tags
{
	import com.codeazur.swfalizer.ISWFDataInput;
	import com.codeazur.utils.StringUtils;
	
	import flash.utils.ByteArray;
	
	public class TagSoundStreamBlock extends Tag implements ITag
	{
		public static const TYPE:uint = 19;
		
		protected var _soundData:ByteArray;
		
		public function TagSoundStreamBlock() {
			_soundData = new ByteArray();
		}
		
		public function get soundData():ByteArray { return _soundData; }
		
		public function parse(data:ISWFDataInput, length:uint):void {
			data.readBytes(_soundData, 0, length)
		}
		
		public function toString(indent:uint = 0):String {
			return StringUtils.repeat(indent) + "[" + StringUtils.printf("%02d", TYPE) + ":TagSoundStreamBlock]";
		}
	}
}
