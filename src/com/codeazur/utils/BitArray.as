package com.codeazur.utils
{
	import flash.utils.ByteArray;
	
	public class BitArray extends ByteArray
	{
		protected var bitsPending:uint = 0;
		
		public function readBits(bits:uint, bitBuffer:uint = 0):uint {
			if (bits == 0) { return bitBuffer; }
			var partial:uint;
			var bitsConsumed:uint;
			if (bitsPending > 0) {
				var byte:uint = this[position - 1] & (0xff >> (8 - bitsPending));
				bitsConsumed = Math.min(bitsPending, bits);
				bitsPending -= bitsConsumed;
				partial = byte >> bitsPending;
			} else {
				bitsConsumed = Math.min(8, bits);
				bitsPending = 8 - bitsConsumed;
				partial = readUnsignedByte() >> bitsPending;
			}
			bits -= bitsConsumed;
			bitBuffer = (bitBuffer << bitsConsumed) | partial;
			return (bits > 0) ? readBits(bits, bitBuffer) : bitBuffer;
		}
		
		public function writeBits(bits:uint, value:uint):void {
			if (bits == 0) { return; }
			value &= (0xffffffff >>> (32 - bits));
			var bitsConsumed:uint;
			if (bitsPending > 0) {
				if (bitsPending > bits) {
					this[position - 1] |= value << (bitsPending - bits);
					bitsConsumed = bits;
					bitsPending -= bits;
				} else if (bitsPending == bits) {
					this[position - 1] |= value;
					bitsConsumed = bits;
					bitsPending = 0;
				} else {
					this[position - 1] |= value >> (bits - bitsPending);
					bitsConsumed = bitsPending;
					bitsPending = 0;
				}
			} else {
				bitsConsumed = Math.min(8, bits);
				bitsPending = 8 - bitsConsumed;
				writeByte((value >> (bits - bitsConsumed)) << bitsPending);
			}
			bits -= bitsConsumed;
			if (bits > 0) {
				writeBits(bits, value);
			}
		}
		
		public function resetBitsPending():void {
			//if (bitsPending > 0) {
			//	trace("### pending:" + bitsPending + " pos:" + (position - 1));
			//}
			bitsPending = 0;
		}
		
		public function getMinBits(a:uint, b:uint = 0, c:uint = 0, d:uint = 0):uint {
			var val:uint = a | b | c | d;
			var bits:uint = 1;
			
			do {
				val >>>= 1;
				++bits;
			}
			while (val != 0)
			
			return bits;
		}
		
		public function getMinSBits(a:int, b:int = 0, c:int = 0, d:int = 0):uint {
			return getMinBits(Math.abs(a), Math.abs(b), Math.abs(c), Math.abs(d));
		}
		 
		public function getMinFBits(a:Number, b:Number = 0, c:Number = 0, d:Number = 0):uint {
			return getMinSBits(a * 65536, b * 65536, c * 65536, d * 65536);
		}
		
		public function calculateMaxBits(signed:Boolean, ...values):uint {
			var b:uint = 0;
			var vmax:int = int.MIN_VALUE;
			for(var i:uint = 0; i < values.length; i++) {
				if(values[i] >= 0) {
					b |= values[i];
				} else {
					b |= ~values[i] << 1;
				}
				if(signed && (vmax < values[i])) {
					vmax = values[i];
				}
			}
			var bits:uint = b.toString(2).length;
			if(signed && vmax > 0 && vmax.toString(2).length >= bits) {
				bits++;
			}
			return bits;
		}
	}
}
