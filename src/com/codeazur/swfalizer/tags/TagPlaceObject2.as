package com.codeazur.swfalizer.tags
{
	import com.codeazur.swfalizer.ISWFDataInput;
	import com.codeazur.swfalizer.data.SWFColorTransform;
	import com.codeazur.swfalizer.data.SWFMatrix;
	import com.codeazur.swfalizer.data.SWFRecordHeader;
	import com.codeazur.utils.StringUtils;
	
	public class TagPlaceObject2 extends TagPlaceObject implements ITag
	{
		public static const TYPE:uint = 26;
		
		public var ratio:uint;
		public var name:String;
		public var clipDepth:uint;
		
		public function TagPlaceObject2() {}
		
		override public function parse(data:ISWFDataInput, length:uint):void {
			var flags:uint = data.readUI8();
			hasClipActions = (flags & 0x80) != 0;
			hasClipDepth = (flags & 0x40) != 0;
			hasName = (flags & 0x20) != 0;
			hasRatio = (flags & 0x10) != 0;
			hasColorTransform = (flags & 0x08) != 0;
			hasMatrix = (flags & 0x04) != 0;
			hasCharacter = (flags & 0x02) != 0;
			hasMove = (flags & 0x01) != 0;
			depth = data.readUI16();
			if (hasCharacter) {
				characterId = data.readUI16();
			}
			if (hasMatrix) {
				matrix = data.readMATRIX();
			}
			if (hasColorTransform) {
				colorTransform = data.readCXFORMWITHALPHA();
			}
			if (hasRatio) {
				ratio = data.readUI16();
			}
			if (hasName) {
				name = data.readString();
			}
			if (hasClipDepth) {
				clipDepth = data.readUI16();
			}
			if (hasClipActions) {
				// TODO: implement readCLIPACTIONS()
				//_clipActions = null;
				throw(new Error("CLIPACTIONS not yet supported."));
			}
		}
		
		override public function toString(indent:uint = 0):String {
			var str:String = StringUtils.repeat(indent) + "[" + StringUtils.printf("%02d", TYPE) + ":TagPlaceObject2] " +
				"Depth: " + depth;
			if (hasCharacter) { str += ", CharacterID: " + characterId; }
			if (hasMatrix) { str += ", Matrix: " + matrix.toString(); }
			if (hasColorTransform) { str += ", ColorTransform: " + colorTransform; }
			if (hasRatio) { str += ", Ratio: " + ratio; }
			if (hasName) { str += ", Name: " + name; }
			return str;
		}
	}
}
