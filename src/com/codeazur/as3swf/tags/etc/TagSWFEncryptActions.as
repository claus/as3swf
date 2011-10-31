package com.codeazur.as3swf.tags.etc
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.tags.ITag;
	import com.codeazur.as3swf.tags.Tag;

	public class TagSWFEncryptActions extends Tag implements ITag
	{
		public static const TYPE:uint = 253;

		public function TagSWFEncryptActions() {}

		public function parse(data:SWFData, length:uint, version:uint):void {
			data.skipBytes(length);
		}

		public function publish(data:SWFData, version:uint):void {
			if (raw != null) {
				data.writeBytes(raw);
			} else {
				throw(new Error("No raw tag data available."));
			}
		}

		override public function get type():uint { return TYPE; }
		override public function get name():String { return "SWFEncryptActions"; }

		public function toString(indent:uint = 0):String {
			return toStringMain(indent) +
				"Length: " + ((raw != null) ? raw.length : "unknown");
		}
	}
}
