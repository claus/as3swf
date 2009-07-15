package com.codeazur.swfalizer.data
{
	import com.codeazur.swfalizer.data.filters.IFilter;
	
	public class SWFButtonRecord
	{
		public static const BLENDMODE_NORMAL_0:uint = 0;
		public static const BLENDMODE_NORMAL_1:uint = 1;
		public static const BLENDMODE_LAYER:uint = 2;
		public static const BLENDMODE_MULTIPLY:uint = 3;
		public static const BLENDMODE_SCREEN:uint = 4;
		public static const BLENDMODE_LIGHTEN:uint = 5;
		public static const BLENDMODE_DARKEN:uint = 6;
		public static const BLENDMODE_DIFFERENCE:uint = 7;
		public static const BLENDMODE_ADD:uint = 8;
		public static const BLENDMODE_SUBTRACT:uint = 9;
		public static const BLENDMODE_INVERT:uint = 10;
		public static const BLENDMODE_ALPHA:uint = 11;
		public static const BLENDMODE_ERASE:uint = 12;
		public static const BLENDMODE_OVERLAY:uint = 13;
		public static const BLENDMODE_HARDLIGHT:uint = 14;
		
		public var hasBlendMode:Boolean;
		public var hasFilterList:Boolean;
		public var stateHitTest:Boolean;
		public var stateDown:Boolean;
		public var stateOver:Boolean;
		public var stateUp:Boolean;
		
		public var characterId:uint;
		public var placeDepth:uint;
		public var placeMatrix:SWFMatrix;
		public var colorTransform:SWFColorTransformWithAlpha;
		public var blendMode:uint;

		protected var _filterList:Vector.<IFilter>;
		
		public function SWFButtonRecord(flags:uint = 0)
		{
			hasBlendMode = (flags & 0x20) != 0;
			hasFilterList = (flags & 0x10) != 0;
			stateHitTest = (flags & 0x08) != 0;
			stateDown = (flags & 0x04) != 0;
			stateOver = (flags & 0x02) != 0;
			stateUp = (flags & 0x01) != 0;
			
			_filterList = new Vector.<IFilter>();
		}
		
		public function get filterList():Vector.<IFilter> { return _filterList; }
		
		public function toString():String {
			var str:String = "Depth: " + placeDepth + ", CharacterID: " + characterId + ", States: ";
			var states:Array = [];
			if (stateUp) { states.push("up"); }
			if (stateOver) { states.push("over"); }
			if (stateDown) { states.push("down"); }
			if (stateHitTest) { states.push("hit"); }
			str += states.join(",");
			return str;
		}
	}
}
