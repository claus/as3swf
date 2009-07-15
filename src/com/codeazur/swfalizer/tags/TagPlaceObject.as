package com.codeazur.swfalizer.tags
{
	import com.codeazur.swfalizer.ISWFDataInput;
	import com.codeazur.swfalizer.data.SWFColorTransform;
	import com.codeazur.swfalizer.data.SWFMatrix;
	import com.codeazur.utils.StringUtils;
	
	public class TagPlaceObject extends Tag implements ITag
	{
		public static const TYPE:uint = 4;
		
		public var hasClipActions:Boolean;
		public var hasClipDepth:Boolean;
		public var hasName:Boolean;
		public var hasRatio:Boolean;
		public var hasColorTransform:Boolean;
		public var hasMatrix:Boolean;
		public var hasCharacter:Boolean;
		public var hasMove:Boolean;

		public var characterId:uint;
		public var depth:uint;
		public var matrix:SWFMatrix;
		public var colorTransform:SWFColorTransform;
		
		public function TagPlaceObject() {}
		
		public function parse(data:ISWFDataInput, length:uint):void {
			var pos:uint = data.position;
			characterId = data.readUI16();
			depth = data.readUI16();
			matrix = data.readMATRIX();
			hasCharacter = true;
			hasMatrix = true;
			if (data.position - pos < length) {
				colorTransform = data.readCXFORM();
				hasColorTransform = true;
			}
		}
		
		public function toString(indent:uint = 0):String {
			var str:String = StringUtils.repeat(indent) + "[" + StringUtils.printf("%02d", TYPE) + ":TagPlaceObject2] " +
				"Depth: " + depth;
			if (hasCharacter) { str += ", CharacterID: " + characterId; }
			if (hasMatrix) { str += ", Matrix: " + matrix; }
			if (hasColorTransform) { str += ", ColorTransform: " + colorTransform; }
			return str;
		}
	}
}
