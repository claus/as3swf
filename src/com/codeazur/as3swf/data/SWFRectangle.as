package com.codeazur.as3swf.data
{
	public class SWFRectangle
	{
		public var xmin:int;
		public var xmax:int;
		public var ymin:int;
		public var ymax:int;
		
		public function SWFRectangle(xmin:int = 0, xmax:int = 0, ymin:int = 0, ymax:int = 0)
		{
			this.xmin = xmin;
			this.xmax = xmax;
			this.ymin = ymin;
			this.ymax = ymax;
		}
		
		public function toString():String {
			return "(" + Number(xmin) / 20 + "," + Number(xmax) / 20 + "," + Number(ymin) / 20 + "," + Number(ymax) / 20 + ")";
		}
		
		public function toStringSize():String {
			return "(" + (Number(xmax) / 20 - Number(xmin) / 20) + "," + (Number(ymax) / 20 - Number(ymin) / 20) + ")";
		}
		
		public function toStringTwips():String {
			return "(" + xmin + "," + xmax + "," + ymin + "," + ymax + ")";
		}
	}
}
