package com.codeazur.as3swf.data.filters
{
	import com.codeazur.as3swf.SWFData;
	
	public class FilterGlow extends Filter implements IFilter
	{
		public var glowColor:uint;
		public var blurX:Number;
		public var blurY:Number;
		public var strength:Number;
		public var innerGlow:Boolean;
		public var knockout:Boolean;
		public var compositeSource:Boolean;
		public var passes:uint;
		
		public function FilterGlow(id:uint) {
			super(id);
		}
		
		override public function parse(data:SWFData):void {
			glowColor = data.readRGBA();
			blurX = data.readFIXED();
			blurY = data.readFIXED();
			strength = data.readFIXED8();
			var flags:uint = data.readUI8();
			innerGlow = ((flags & 0x80) != 0);
			knockout = ((flags & 0x40) != 0);
			compositeSource = ((flags & 0x20) != 0);
			passes = flags & 0x1f;
		}
	}
}
