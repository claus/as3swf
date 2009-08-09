package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.SWFSoundInfo;
	
	public class TagDefineButtonSound extends Tag implements ITag
	{
		public static const TYPE:uint = 17;
		
		public var buttonId:uint;
		public var buttonSoundChar0:uint;
		public var buttonSoundChar1:uint;
		public var buttonSoundChar2:uint;
		public var buttonSoundChar3:uint;
		public var buttonSoundInfo0:SWFSoundInfo;
		public var buttonSoundInfo1:SWFSoundInfo;
		public var buttonSoundInfo2:SWFSoundInfo;
		public var buttonSoundInfo3:SWFSoundInfo;
		
		public function TagDefineButtonSound() {}
		
		public function parse(data:SWFData, length:uint, version:uint):void {
			buttonId = data.readUI16();
			buttonSoundChar0 = data.readUI16();
			if (buttonSoundChar0 != 0) {
				buttonSoundInfo0 = data.readSOUNDINFO();
			}
			buttonSoundChar1 = data.readUI16();
			if (buttonSoundChar1 != 0) {
				buttonSoundInfo1 = data.readSOUNDINFO();
			}
			buttonSoundChar2 = data.readUI16();
			if (buttonSoundChar2 != 0) {
				buttonSoundInfo2 = data.readSOUNDINFO();
			}
			buttonSoundChar3 = data.readUI16();
			if (buttonSoundChar3 != 0) {
				buttonSoundInfo3 = data.readSOUNDINFO();
			}
		}
		
		public function publish(data:SWFData, version:uint):void {
			throw(new Error("TODO: implement publish()"));
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "DefineButtonSound"; }
		
		public function toString(indent:uint = 0):String {
			var str:String = toStringMain(indent) +
				"ButtonID: " + buttonId + ", " +
				"ButtonSoundChars: " + buttonSoundChar0 + "," + buttonSoundChar1 + "," + buttonSoundChar2 + "," + buttonSoundChar3;;
			return str;
		}
	}
}
