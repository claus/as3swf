package com.codeazur.swfalizer.data.filters
{
	import com.codeazur.swfalizer.ISWFDataInput;
	
	public class FilterBlur extends Filter implements IFilter
	{
		public var blurX:Number;
		public var blurY:Number;
		public var passes:uint;
		
		public function FilterBlur(id:uint) {
			super(id);
		}
		
		override public function parse(data:ISWFDataInput):void {
			blurX = data.readFIXED();
			blurY = data.readFIXED();
			passes = data.readUI8() >> 3;
		}
	}
}
