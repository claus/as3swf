package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.SWFSoundInfo;
	
	public class TagStartSound2 extends Tag implements ITag
	{
		public static const TYPE:uint = 89;
		
		public var soundClassName:String;
		public var soundInfo:SWFSoundInfo;
		
		public function TagStartSound2() {}
		
		public function parse(data:SWFData, length:uint, version:uint):void {
			soundClassName = data.readString();
			soundInfo = data.readSOUNDINFO();
		}
		
		public function publish(data:SWFData, version:uint):void {
			throw(new Error("TODO: implement publish()"));
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "StartSound2"; }
		override public function get version():uint { return 9; }
		
		public function toString(indent:uint = 0):String {
			var str:String = toStringMain(indent) +
				"SoundClassName: " + soundClassName + ", " +
				"SoundInfo: " + soundInfo;
			return str;
		}
	}
}
