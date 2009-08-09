package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.SWFClipActions;
	import com.codeazur.utils.StringUtils;
	
	public class TagPlaceObject2 extends TagPlaceObject implements ITag
	{
		public static const TYPE:uint = 26;
		
		public var ratio:uint;
		public var objName:String;
		public var clipDepth:uint;
		public var clipActions:SWFClipActions;
		
		public function TagPlaceObject2() {}
		
		override public function parse(data:SWFData, length:uint, version:uint):void {
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
				objName = data.readString();
			}
			if (hasClipDepth) {
				clipDepth = data.readUI16();
			}
			if (hasClipActions) {
				clipActions = data.readCLIPACTIONS(version);
			}
		}
		
		override public function publish(data:SWFData, version:uint):void {
			throw(new Error("TODO: implement publish()"));
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "PlaceObject2"; }
		
		override public function toString(indent:uint = 0):String {
			var str:String = toStringMain(indent) +
				"Depth: " + depth;
			if (hasCharacter) { str += ", CharacterID: " + characterId; }
			if (hasMatrix) { str += ", Matrix: " + matrix.toString(); }
			if (hasColorTransform) { str += ", ColorTransform: " + colorTransform; }
			if (hasRatio) { str += ", Ratio: " + ratio; }
			if (hasName) { str += ", Name: " + objName; }
			if (hasClipActions) {
				str += "\n" + StringUtils.repeat(indent + 2) + clipActions.toString(indent + 2);
			}
			return str;
		}
	}
}
