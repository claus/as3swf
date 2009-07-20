﻿package com.codeazur.as3swf.data
{
	import com.codeazur.as3swf.ISWFDataInput;
	
	public class SWFSoundEnvelope
	{
		public var pos44:uint;
		public var leftLevel:uint;
		public var rightLevel:uint;
		
		public function SWFSoundEnvelope(data:ISWFDataInput = null) {
			if (data != null) {
				parse(data);
			}
		}
		
		public function parse(data:ISWFDataInput):void {
			pos44 = data.readUI32();
			leftLevel = data.readUI16();
			rightLevel = data.readUI16();
		}
		
		public function toString():String {
			return "[SWFSoundEnvelope]";
		}
	}
}
