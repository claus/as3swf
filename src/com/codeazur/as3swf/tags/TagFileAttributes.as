package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	
	public class TagFileAttributes extends Tag implements ITag
	{
		public static const TYPE:uint = 69;
		
		public var useDirectBlit:Boolean;
		public var useGPU:Boolean;
		public var hasMetadata:Boolean;
		public var actionscript3:Boolean;
		public var useNetwork:Boolean;

		public function TagFileAttributes() {}
		
		public function parse(data:SWFData, length:uint, version:uint):void {
			var flags:uint = data.readUI8();
			useDirectBlit = ((flags & 0x40) != 0);
			useGPU = ((flags & 0x20) != 0);
			hasMetadata = ((flags & 0x10) != 0);
			actionscript3 = ((flags & 0x08) != 0);
			useNetwork = ((flags & 0x01) != 0);
			data.skipBytes(3);
		}
		
		public function publish(data:SWFData, version:uint):void {
			data.writeTagHeader(type, 4);
			var flags:uint = 0;
			if (useNetwork) { flags |= 0x01; }
			if (actionscript3) { flags |= 0x08; }
			if (hasMetadata) { flags |= 0x10; }
			if (useGPU) { flags |= 0x20; }
			if (useDirectBlit) { flags |= 0x40; }
			data.writeUI8(flags);
			data.writeUI8(0);
			data.writeUI8(0);
			data.writeUI8(0);
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "FileAttributes"; }
		override public function get version():uint { return 8; }
		
		public function toString(indent:uint = 0):String {
			return toStringMain(indent) +
				"AS3: " + actionscript3 + ", " +
				"HasMetadata: " + hasMetadata + ", " +
				"UseDirectBlit: " + useDirectBlit + ", " +
				"UseGPU: " + useGPU + ", " +
				"UseNetwork: " + useNetwork;
		}
	}
}
