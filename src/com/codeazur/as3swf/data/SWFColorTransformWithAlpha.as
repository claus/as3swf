package com.codeazur.as3swf.data
{
	import com.codeazur.as3swf.SWFData;
	
	public class SWFColorTransformWithAlpha extends SWFColorTransform
	{
		public function SWFColorTransformWithAlpha(data:SWFData = null) {
			super(data);
		}
		
		override public function parse(data:SWFData):void {
			data.resetBitsPending();
			var hasAddTerms:uint = data.readUB(1);
			var hasMultTerms:uint = data.readUB(1);
			var bits:uint = data.readUB(4);
			rMult = 1;
			gMult = 1;
			bMult = 1;
			aMult = 1;
			if (hasMultTerms == 1) {
				rMult = data.readSB(bits);
				gMult = data.readSB(bits);
				bMult = data.readSB(bits);
				aMult = data.readSB(bits);
			}
			rAdd = 0;
			gAdd = 0;
			bAdd = 0;
			aAdd = 0;
			if (hasAddTerms == 1) {
				rAdd = data.readSB(bits);
				gAdd = data.readSB(bits);
				bAdd = data.readSB(bits);
				aAdd = data.readSB(bits);
			}
		}
		
		override public function toString():String {
			return rMult + "," + gMult + "," + bMult + "," + aMult + "," + rAdd + "," + gAdd + "," + bAdd + "," + aAdd;
		}
	}
}
