package com.codeazur.swfalizer.tags
{
	import com.codeazur.swfalizer.ISWFDataInput;
	import com.codeazur.utils.StringUtils;
	
	public class TagFileAttributes extends Tag implements ITag
	{
		public static const TYPE:uint = 69;
		
		public var useDirectBlit:Boolean;
		public var useGPU:Boolean;
		public var hasMetadata:Boolean;
		public var actionscript3:Boolean;
		public var useNetwork:Boolean;

		public function TagFileAttributes() {}
		
		public function parse(data:ISWFDataInput, length:uint):void {
			var flags:uint = data.readUI8();
			useDirectBlit = ((flags & 0x40) != 0);
			useGPU = ((flags & 0x20) != 0);
			hasMetadata = ((flags & 0x10) != 0);
			actionscript3 = ((flags & 0x08) != 0);
			useNetwork = ((flags & 0x01) != 0);
			data.skipBytes(3);
		}
		
		public function toString(indent:uint = 0):String {
			return StringUtils.repeat(indent) + "[" + StringUtils.printf("%02d", TYPE) + ":TagFileAttributes] " +
				"AS3: " + actionscript3 + ", " +
				"HasMetadata: " + hasMetadata + ", " +
				"UseDirectBlit: " + useDirectBlit + ", " +
				"UseGPU: " + useGPU + ", " +
				"UseNetwork: " + useNetwork;
		}
	}
}
