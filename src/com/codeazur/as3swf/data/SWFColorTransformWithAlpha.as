package com.codeazur.as3swf.data
{
	public class SWFColorTransformWithAlpha extends SWFColorTransform
	{
		public function SWFColorTransformWithAlpha(rMult:int, gMult:int, bMult:int, rAdd:int, gAdd:int, bAdd:int, aMult:int, aAdd:int)
		{
			super(rMult, gMult, bMult, rAdd, gAdd, bAdd);
			this.aMult = aMult;
			this.aAdd = aAdd;
		}
		
		override public function toString():String {
			return rMult + "," + gMult + "," + bMult + "," + aMult + "," + rAdd + "," + gAdd + "," + bAdd + "," + aAdd;
		}
	}
}
