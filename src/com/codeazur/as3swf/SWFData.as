package com.codeazur.as3swf
{
	import com.codeazur.as3swf.actions.IAction;
	import com.codeazur.as3swf.data.*;
	import com.codeazur.as3swf.data.filters.*;
	import com.codeazur.as3swf.factories.*;

	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	public class SWFData implements ISWFDataInput
	{
		protected var data:ByteArray;
		
		protected var bitsPending:uint = 0;
		
		public function SWFData(data:ByteArray)
		{
			this.data = data;
			this.data.endian = Endian.LITTLE_ENDIAN;
		}

		/////////////////////////////////////////////////////////
		// Integers
		/////////////////////////////////////////////////////////
		
		public function readSI8():int {
			resetBitsPending();
			return data.readByte();
		}
		
		public function readSI16():int {
			resetBitsPending();
			return data.readShort();
		}
		
		public function readSI32():int {
			resetBitsPending();
			return data.readInt();
		}
		
		public function readUI8():uint {
			resetBitsPending();
			return data.readUnsignedByte();
		}
		
		public function readUI16():uint {
			resetBitsPending();
			return data.readUnsignedShort();
		}
		
		public function readUI24():uint {
			resetBitsPending();
			var loWord:uint = data.readUnsignedShort();
			var hiByte:uint = data.readUnsignedByte();
			return loWord | (hiByte << 16);
		}
		
		public function readUI32():uint {
			resetBitsPending();
			return data.readUnsignedInt();
		}
		
		/////////////////////////////////////////////////////////
		// Fixed-point numbers
		/////////////////////////////////////////////////////////
		
		public function readFIXED():Number {
			resetBitsPending();
			var fractional:Number = data.readUnsignedShort();
			var integral:Number = data.readUnsignedShort();
			return integral + fractional / 65536;
		}
		
		public function readFIXED8():Number {
			resetBitsPending();
			var fractional:Number = data.readUnsignedByte();
			var integral:Number = data.readUnsignedByte();
			return integral + fractional / 256;
		}
		
		/////////////////////////////////////////////////////////
		// Floating-point numbers
		/////////////////////////////////////////////////////////
		
		public function readFLOAT():Number {
			resetBitsPending();
			return data.readFloat();
		}
		
		public function readFLOAT16():Number {
			resetBitsPending();
			var word:uint = data.readUnsignedShort();
			var exp:uint = (word >> 10) & 0x1f;
			var man:uint = (word & 0x3FF);
			return ((word & 0x8000) ? man : -man) * Math.pow(2, exp - 16);
		}
		
		public function readDOUBLE():Number {
			resetBitsPending();
			return data.readDouble();
		}
		
		/////////////////////////////////////////////////////////
		// Encoded integer
		/////////////////////////////////////////////////////////
		
		public function readEncodedU32():uint {
			resetBitsPending();
			var result:uint = data.readUnsignedByte();
			if (result & 0x80) {
				result = (result & 0x7f) | (data.readUnsignedByte() << 7);
				if (result & 0x4000) {
					result = (result & 0x3fff) | (data.readUnsignedByte() << 14);
					if (result & 0x200000) {
						result = (result & 0x1fffff) | (data.readUnsignedByte() << 21);
						if (result & 0x10000000) {
							result = (result & 0xfffffff) | (data.readUnsignedByte() << 28);
						}
					}
				}
			}
			return result;
		}
		
		/////////////////////////////////////////////////////////
		// Bit values
		/////////////////////////////////////////////////////////
		
		public function readUB(bits:uint):uint {
			return readBits(bits);
		}

		public function readSB(bits:uint):int {
			var shift:uint = 32 - bits;
			return int(readBits(bits) << shift) >> shift;
		}
		
		public function readFB(bits:uint):Number {
			return Number(readSB(bits)) / 65536;
		}
		
		/////////////////////////////////////////////////////////
		// String
		/////////////////////////////////////////////////////////
		
		public function readString():String {
			var c:uint;
			var ba:ByteArray = new ByteArray();
			while ((c = data.readUnsignedByte()) != 0) {
				ba.writeByte(c);
			}
			ba.position = 0;
			resetBitsPending();
			return ba.readUTFBytes(ba.length);
		}
		
		/////////////////////////////////////////////////////////
		// Labguage code
		/////////////////////////////////////////////////////////
		
		public function readLANGCODE():uint {
			resetBitsPending();
			return data.readUnsignedByte();
		}
		
		/////////////////////////////////////////////////////////
		// Color records
		/////////////////////////////////////////////////////////
		
		public function readRGB():uint {
			resetBitsPending();
			var r:uint = data.readUnsignedByte();
			var g:uint = data.readUnsignedByte();
			var b:uint = data.readUnsignedByte();
			return 0xff000000 | (r << 16) | (g << 8) | b;
		}
		
		public function readRGBA():uint {
			resetBitsPending();
			var rgb:uint = readRGB() & 0x00ffffff;
			var a:uint = data.readUnsignedByte();
			return a << 24 | rgb;
		}
		
		public function readARGB():uint {
			resetBitsPending();
			var a:uint = data.readUnsignedByte();
			var rgb:uint = readRGB() & 0x00ffffff;
			return (a << 24) | rgb;
		}
		
		/////////////////////////////////////////////////////////
		// Rectangle record
		/////////////////////////////////////////////////////////
		
		public function readRECT():SWFRectangle {
			return new SWFRectangle(this);
		}
		
		/////////////////////////////////////////////////////////
		// Matrix record
		/////////////////////////////////////////////////////////
		
		public function readMATRIX():SWFMatrix {
			return new SWFMatrix(this);
		}
		
		/////////////////////////////////////////////////////////
		// Color transform records
		/////////////////////////////////////////////////////////
		
		public function readCXFORM():SWFColorTransform {
			return new SWFColorTransform(this);
		}
		
		public function readCXFORMWITHALPHA():SWFColorTransformWithAlpha {
			return new SWFColorTransformWithAlpha(this);
		}
		
		
		/////////////////////////////////////////////////////////
		// Shape and shape records
		/////////////////////////////////////////////////////////
		
		public function readSHAPE():SWFShape {
			return new SWFShape(this);
		}
		
		public function readSHAPEWITHSTYLE(level:uint = 1):SWFShapeWithStyle {
			return new SWFShapeWithStyle(this, level);
		}

		public function readSTRAIGHTEDGERECORD(numBits:uint):SWFShapeRecordStraightEdge {
			return new SWFShapeRecordStraightEdge(this, numBits);
		}
		
		public function readCURVEDEDGERECORD(numBits:uint):SWFShapeRecordCurvedEdge {
			return new SWFShapeRecordCurvedEdge(this, numBits);
		}
		
		public function readSTYLECHANGERECORD(states:uint, fillBits:uint, lineBits:uint, level:uint = 1):SWFShapeRecordStyleChange {
			return new SWFShapeRecordStyleChange(this, states, fillBits, lineBits, level);
		}
		

		/////////////////////////////////////////////////////////
		// Fill- and Linestyles
		/////////////////////////////////////////////////////////
		
		public function readFILLSTYLE(level:uint = 1):SWFFillStyle {
			return new SWFFillStyle(this, level);
		}
		
		public function readLINESTYLE(level:uint = 1):SWFLineStyle {
			return new SWFLineStyle(this, level);
		}
		
		public function readLINESTYLE2(level:uint = 1):SWFLineStyle2 {
			return new SWFLineStyle2(this, level);
		}
		
		/////////////////////////////////////////////////////////
		// Button record
		/////////////////////////////////////////////////////////
		
		public function readBUTTONRECORD(level:uint = 1):SWFButtonRecord {
			if (readUI8() == 0) {
				return null;
			} else {
				data.position--;
				return new SWFButtonRecord(this, level);
			}
		}

		public function readBUTTONCONDACTION():SWFButtonCondAction {
			return new SWFButtonCondAction(this);
		}
		
		/////////////////////////////////////////////////////////
		// Filter
		/////////////////////////////////////////////////////////
		
		public function readFILTER():IFilter {
			var filterId:uint = readUI8();
			var filter:IFilter = SWFFilterFactory.create(filterId);
			filter.parse(this);
			return filter;
		}
		
		/////////////////////////////////////////////////////////
		// Text record
		/////////////////////////////////////////////////////////
		
		public function readTEXTRECORD(glyphBits:uint, advanceBits:uint, previousRecord:SWFTextRecord = null, level:uint = 1):SWFTextRecord {
			if (readUI8() == 0) {
				return null;
			} else {
				data.position--;
				return new SWFTextRecord(this, glyphBits, advanceBits, previousRecord, level);
			}
		}

		public function readGLYPHENTRY(glyphBits:uint, advanceBits:uint):SWFGlyphEntry {
			return new SWFGlyphEntry(this, glyphBits, advanceBits);
		}

		/////////////////////////////////////////////////////////
		// Zone record
		/////////////////////////////////////////////////////////
		
		public function readZONERECORD():SWFZoneRecord {
			return new SWFZoneRecord(this);
		}

		public function readZONEDATA():SWFZoneData {
			return new SWFZoneData(this);
		}

		/////////////////////////////////////////////////////////
		// Kerning record
		/////////////////////////////////////////////////////////
		
		public function readKERNINGRECORD(wideCodes:Boolean):SWFKerningRecord {
			return new SWFKerningRecord(this, wideCodes);
		}

		/////////////////////////////////////////////////////////
		// Gradients
		/////////////////////////////////////////////////////////
		
		public function readGRADIENT(level:uint = 1):SWFGradient {
			return new SWFGradient(this, level);
		}
		
		public function readFOCALGRADIENT(level:uint = 1):SWFFocalGradient {
			return new SWFFocalGradient(this, level);
		}
		
		public function readGRADIENTRECORD(level:uint = 1):SWFGradientRecord {
			return new SWFGradientRecord(this, level);
		}
		
		/////////////////////////////////////////////////////////
		// Action records
		/////////////////////////////////////////////////////////
		
		public function readACTIONRECORD():IAction {
			var action:IAction;
			var actionCode:uint = readUI8();
			if (actionCode != 0) {
				var actionLength:uint = (actionCode >= 0x80) ? readUI16() : 0;
				action = SWFActionFactory.create(actionCode, actionLength);
				action.parse(this);
			}
			return action;
		}
		
		public function readACTIONVALUE():SWFActionValue {
			return new SWFActionValue(this);
		}
		
		public function readREGISTERPARAM():SWFRegisterParam {
			return new SWFRegisterParam(this);
		}
		
		/////////////////////////////////////////////////////////
		// Symbols
		/////////////////////////////////////////////////////////
		
		public function readSYMBOL():SWFSymbol {
			return new SWFSymbol(this);
		}
		
		/////////////////////////////////////////////////////////
		// Sound records
		/////////////////////////////////////////////////////////
		
		public function readSOUNDINFO():SWFSoundInfo {
			return new SWFSoundInfo(this);
		}
		
		public function readSOUNDENVELOPE():SWFSoundEnvelope {
			return new SWFSoundEnvelope(this);
		}
		
		
		
		/////////////////////////////////////////////////////////
		// etc
		/////////////////////////////////////////////////////////
		
		public function uncompress():void {
			var position:uint = data.position;
			var ba:ByteArray = new ByteArray();
			data.readBytes(ba);
			ba.position = 0;
			ba.uncompress();
			data.length = data.position = position;
			data.writeBytes(ba);
			data.position = position;
		}
		
		
		public function get position():uint {
			return data.position;
		}
		
		public function resetBitsPending():void {
			bitsPending = 0;
		}

		public function readBytes(bytes:ByteArray, offset:uint = 0, length:uint = 0):void {
			data.readBytes(bytes, offset, length);
		}
		
		public function skipBytes(length:uint):void {
			data.position += length;
		}
		
		
		public function dump(length:uint, rewind:uint = 0):void {
			var pos:uint = data.position;
			data.position -= rewind;
			var str:String = "bitsPending:" + bitsPending + ", ";
			for (var i:uint = 0; i < length; i++) {
				str += data.readUnsignedByte().toString(16) + " ";
			}
			data.position = pos;
			trace(str);
		}
		
		
		protected function readBits(bits:uint, bitBuffer:uint = 0):uint {
			if (bits == 0) { return bitBuffer; }
			var partial:uint;
			var bitsConsumed:uint;
			if (bitsPending > 0) {
				var byte:uint = data[data.position - 1] & (0xff >> (8 - bitsPending));
				bitsConsumed = Math.min(bitsPending, bits);
				bitsPending -= bitsConsumed;
				partial = byte >> bitsPending;
			} else {
				bitsConsumed = Math.min(8, bits);
				bitsPending = 8 - bitsConsumed;
				partial = data.readUnsignedByte() >> bitsPending;
			}
			bits -= bitsConsumed;
			bitBuffer = (bitBuffer << bitsConsumed) | partial;
			return (bits > 0) ? readBits(bits, bitBuffer) : bitBuffer;
		}
	}
}
