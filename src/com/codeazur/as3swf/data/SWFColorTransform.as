package com.codeazur.as3swf.data
{
	import com.codeazur.as3swf.SWFData;
	
	public class SWFColorTransform
	{
		public var rMult:int = 1;
		public var gMult:int = 1;
		public var bMult:int = 1;
		public var rAdd:int = 0;
		public var gAdd:int = 0;
		public var bAdd:int = 0;

		public var aMult:int = 1;
		public var aAdd:int = 0;
		
		public function SWFColorTransform(data:SWFData) {
			if (data != null) {
				parse(data);
			}
		}
		
		public function parse(data:SWFData):void {
			data.resetBitsPending();
			var hasAddTerms:uint = data.readUB(1);
			var hasMultTerms:uint = data.readUB(1);
			var bits:uint = data.readUB(4);
			rMult = 1;
			gMult = 1;
			bMult = 1;
			if (hasMultTerms == 1) {
				rMult = data.readSB(bits);
				gMult = data.readSB(bits);
				bMult = data.readSB(bits);
			}
			rAdd = 0;
			gAdd = 0;
			bAdd = 0;
			if (hasAddTerms == 1) {
				rAdd = data.readSB(bits);
				gAdd = data.readSB(bits);
				bAdd = data.readSB(bits);
			}
		}
		
		public function toString():String {
			return rMult + "," + gMult + "," + bMult + "," + rAdd + "," + gAdd + "," + bAdd;
		}
	}
}
