package com.codeazur.as3swf.data
{
	import com.codeazur.as3swf.ISWFDataInput;
	
	public class SWFFocalGradient extends SWFGradient
	{
		public var focalPoint:Number;
		
		public function SWFFocalGradient(data:ISWFDataInput = null, level:uint = 1) {
			super(data, level);
		}
		
		override public function parse(data:ISWFDataInput, level:uint):void {
			super.parse(data, level);
			focalPoint = data.readFIXED8();
		}
		
		override public function toString():String {
			return "(" + _records.join(",") + ")";
		}
	}
}
