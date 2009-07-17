package com.codeazur.as3swf.data
{
	import com.codeazur.as3swf.data.filters.IFilter;
	import com.codeazur.as3swf.data.consts.BlendMode;
	
	public class SWFButtonRecord
	{
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
