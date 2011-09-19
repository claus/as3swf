package com.codeazur.as3swf.data
{
	import flash.geom.ColorTransform;
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
		
		public var hasMultTerms:Boolean;
		public var hasAddTerms:Boolean;
		
		public function SWFColorTransform(data:SWFData = null) {
			if (data != null) {
				parse(data);
			}
		}
		
		public function get colorTransform():ColorTransform {
			return new ColorTransform(rMult, gMult, bMult, aMult, rAdd, gAdd, bAdd, aAdd);
		}
		
		public function parse(data:SWFData):void {
			data.resetBitsPending();
			hasAddTerms = (data.readUB(1) == 1);
			hasMultTerms = (data.readUB(1) == 1);
			var bits:uint = data.readUB(4);
			rMult = 1;
			gMult = 1;
			bMult = 1;
			if (hasMultTerms) {
				rMult = data.readSB(bits);
				gMult = data.readSB(bits);
				bMult = data.readSB(bits);
			}
			rAdd = 0;
			gAdd = 0;
			bAdd = 0;
			if (hasAddTerms) {
				rAdd = data.readSB(bits);
				gAdd = data.readSB(bits);
				bAdd = data.readSB(bits);
			}
		}
		
		public function publish(data:SWFData):void {
			data.resetBitsPending();
			data.writeUB(1, hasAddTerms ? 1 : 0);
			data.writeUB(1, hasMultTerms ? 1 : 0);
			var values:Array = [];
			if (hasMultTerms) { values.push(rMult, gMult, bMult); }
			if (hasAddTerms) { values.push(rAdd, gAdd, bAdd); }
			var bits:uint = data.calculateMaxBits(true, values);
			data.writeUB(4, bits);
			if (hasMultTerms) {
				data.writeSB(bits, rMult);
				data.writeSB(bits, gMult);
				data.writeSB(bits, bMult);
			}
			if (hasAddTerms) {
				data.writeSB(bits, rAdd);
				data.writeSB(bits, gAdd);
				data.writeSB(bits, bAdd);
			}
		}
		
		public function clone():SWFColorTransform {
			var colorTransform:SWFColorTransform = new SWFColorTransform();
			colorTransform.hasAddTerms = hasAddTerms;
			colorTransform.hasMultTerms = hasMultTerms;
			colorTransform.rMult = rMult;
			colorTransform.gMult = gMult;
			colorTransform.bMult = bMult;
			colorTransform.rAdd = rAdd;
			colorTransform.gAdd = gAdd;
			colorTransform.bAdd = bAdd;
			return colorTransform;
		}
		
		public function isIdentity():Boolean {
			return (rMult == 1 && gMult == 1 && bMult == 1 && aMult == 1)
				&& (rAdd == 0 && gAdd == 0 && bAdd == 0 && aAdd == 0);
		}
		
		public function toString():String {
			return rMult + "," + gMult + "," + bMult + "," + rAdd + "," + gAdd + "," + bAdd;
		}
	}
}
