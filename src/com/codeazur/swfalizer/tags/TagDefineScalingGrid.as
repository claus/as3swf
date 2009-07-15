package com.codeazur.swfalizer.tags
{
	import com.codeazur.swfalizer.ISWFDataInput;
	import com.codeazur.swfalizer.data.SWFRectangle;
	import com.codeazur.utils.StringUtils;
	
	public class TagDefineScalingGrid extends Tag implements ITag
	{
		public static const TYPE:uint = 78;
		
		public var characterId:uint;
		public var splitter:SWFRectangle;
		
		public function TagDefineScalingGrid() {}
		
		public function parse(data:ISWFDataInput, length:uint):void {
			characterId = data.readUI16();
			splitter = data.readRECT();
		}
		
		public function toString(indent:uint = 0):String {
			return StringUtils.repeat(indent) + "[" + StringUtils.printf("%02d", TYPE) + ":TagDefineScalingGrid] " +
				"CharacterID: " + characterId + ", " +
				"Splitter: " + splitter;
		}
	}
}
