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
	}
}
