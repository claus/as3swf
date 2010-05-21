package com.codeazur.as3swf.data.filters
{
	import com.codeazur.as3swf.SWFData;
	
	public class FilterBlur extends Filter implements IFilter
	{
		public var blurX:Number;
		public var blurY:Number;
		public var passes:uint;
		
		public function FilterBlur(id:uint) {
			super(id);
		}
		
		override public function parse(data:SWFData):void {
			blurX = data.readFIXED();
			blurY = data.readFIXED();
			passes = data.readUI8() >> 3;
		}
		
		override public function publish(data:SWFData):void {
			data.writeFIXED(blurX);
			data.writeFIXED(blurY);
			data.writeUI8(passes << 3);
		}
		
		override public function toString(indent:uint = 0):String {
			return "[BlurFilter] " +
				"BlurX: " + blurX + ", " +
				"BlurY: " + blurY + ", " +
				"Passes: " + passes;
		}
	}
}
