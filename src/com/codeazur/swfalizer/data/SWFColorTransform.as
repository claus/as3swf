package com.codeazur.swfalizer.data
{
	public class SWFColorTransform
	{
		public var rMult:int;
		public var gMult:int;
		public var bMult:int;
		public var rAdd:int;
		public var gAdd:int;
		public var bAdd:int;

		public var aMult:int;
		public var aAdd:int;
		
		public function SWFColorTransform(rMult:int, gMult:int, bMult:int, rAdd:int, gAdd:int, bAdd:int)
		{
			this.rMult = rMult;
			this.gMult = gMult;
			this.bMult = bMult;
			this.rAdd = rAdd;
			this.gAdd = gAdd;
			this.bAdd = bAdd;
			
			this.aMult = 1;
			this.aAdd = 0;
		}
		
		public function toString():String {
			return rMult + "," + gMult + "," + bMult + "," + rAdd + "," + gAdd + "," + bAdd;
		}
	}
}
