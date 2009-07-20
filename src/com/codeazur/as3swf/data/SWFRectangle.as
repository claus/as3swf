package com.codeazur.as3swf.data
{
	import com.codeazur.as3swf.ISWFDataInput;
	
	public class SWFRectangle
	{
		public var xmin:int;
		public var xmax:int;
		public var ymin:int;
		public var ymax:int;
		
		public function SWFRectangle(data:ISWFDataInput = null) {
			if (data != null) {
				parse(data);
			}
		}

		public function parse(data:ISWFDataInput):void {
			data.resetBitsPending();
			var bits:uint = data.readUB(5);
			xmin = data.readSB(bits);
			xmax = data.readSB(bits);
			ymin = data.readSB(bits);
			ymax = data.readSB(bits);
		}
		
		public function toString():String {
			return "(" + xmin + "," + xmax + "," + ymin + "," + ymax + ")";
		}
		
		public function toStringSize():String {
			return "(" + (Number(xmax) / 20 - Number(xmin) / 20) + "," + (Number(ymax) / 20 - Number(ymin) / 20) + ")";
		}
	}
}
