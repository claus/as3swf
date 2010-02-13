package com.codeazur.as3swf.data.filters
{
	import com.codeazur.as3swf.SWFData;
	
	public class FilterDropShadow extends Filter implements IFilter
	{
		public var dropShadowColor:uint;
		public var blurX:Number;
		public var blurY:Number;
		public var angle:Number;
		public var distance:Number;
		public var strength:Number;
		public var innerShadow:Boolean;
		public var knockout:Boolean;
		public var compositeSource:Boolean;
		public var passes:uint;
		
		public function FilterDropShadow(id:uint) {
			super(id);
		}
		
		override public function parse(data:SWFData):void {
			dropShadowColor = data.readRGBA();
			blurX = data.readFIXED();
			blurY = data.readFIXED();
			angle = data.readFIXED();
			distance = data.readFIXED();
			strength = data.readFIXED8();
			var flags:uint = data.readUI8();
			innerShadow = ((flags & 0x80) != 0);
			knockout = ((flags & 0x40) != 0);
			compositeSource = ((flags & 0x20) != 0);
			passes = flags & 0x1f;
		}
		
		override public function publish(data:SWFData):void {
			data.writeRGBA(dropShadowColor);
			data.writeFIXED(blurX);
			data.writeFIXED(blurY);
			data.writeFIXED(angle);
			data.writeFIXED(distance);
			data.writeFIXED8(strength);
			var flags:uint = (passes & 0x1f);
			if(innerShadow) { flags |= 0x80; }
			if(knockout) { flags |= 0x40; }
			if(compositeSource) { flags |= 0x20; }
			data.writeUI8(flags);
		}
	}
}
