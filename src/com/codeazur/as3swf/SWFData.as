package com.codeazur.as3swf
{
	import com.codeazur.as3swf.data.*;
	import com.codeazur.as3swf.data.actions.IAction;
	import com.codeazur.as3swf.data.filters.*;
	import com.codeazur.as3swf.factories.*;
	import com.codeazur.utils.BitArray;

	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	public class SWFData extends BitArray
	{
		public static const FLOAT16_EXPONENT_BASE:Number = 16;
		
		public function SWFData() {
			endian = Endian.LITTLE_ENDIAN;
		}

		/////////////////////////////////////////////////////////
		// Integers
		/////////////////////////////////////////////////////////
		
		public function readSI8():int {
			resetBitsPending();
			return readByte();
		}
		
		public function writeSI8(value:int):void {
			resetBitsPending();
			writeByte(value);
		}

		public function readSI16():int {
			resetBitsPending();
			return readShort();
		}
		
		public function writeSI16(value:int):void {
			resetBitsPending();
			writeShort(value);
		}

		public function readSI32():int {
			resetBitsPending();
			return readInt();
		}
		
		public function writeSI32(value:int):void {
			resetBitsPending();
			writeInt(value);
		}

		public function readUI8():uint {
			resetBitsPending();
			return readUnsignedByte();
		}
		
		public function writeUI8(value:uint):void {
			resetBitsPending();
			writeByte(value);
		}

		public function readUI16():uint {
			resetBitsPending();
			return readUnsignedShort();
		}
		
		public function writeUI16(value:uint):void {
			resetBitsPending();
			writeShort(value);
		}

		public function readUI24():uint {
			resetBitsPending();
			var loWord:uint = readUnsignedShort();
			var hiByte:uint = readUnsignedByte();
			return (hiByte << 16) | loWord;
		}
		
		public function writeUI24(value:uint):void {
			resetBitsPending();
			writeShort(value & 0xffff);
			writeByte(value >> 16);
		}
		
		public function readUI32():uint {
			resetBitsPending();
			return readUnsignedInt();
		}
		
		public function writeUI32(value:uint):void {
			resetBitsPending();
			writeUnsignedInt(value);
		}
		
		/////////////////////////////////////////////////////////
		// Fixed-point numbers
		/////////////////////////////////////////////////////////
		
		public function readFIXED():Number {
			resetBitsPending();
			return readInt() / 65536;
		}
		
		public function writeFIXED(value:Number):void {
			resetBitsPending();
			writeInt(int(value * 65536));
		}

		public function readFIXED8():Number {
			resetBitsPending();
			return readShort() / 256;
		}

		public function writeFIXED8(value:Number):void {
			resetBitsPending();
			writeShort(int(value * 256));
		}

		/////////////////////////////////////////////////////////
		// Floating-point numbers
		/////////////////////////////////////////////////////////
		
		public function readFLOAT():Number {
			resetBitsPending();
			return readFloat();
		}
		
		public function writeFLOAT(value:Number):void {
			resetBitsPending();
			writeFloat(value);
		}

		public function readDOUBLE():Number {
			resetBitsPending();
			return readDouble();
		}

		public function writeDOUBLE(value:Number):void {
			resetBitsPending();
			writeDouble(value);
		}

		public function readFLOAT16():Number {
			resetBitsPending();
			var word:uint = readUnsignedShort();
			var sign:int = ((word & 0x8000) != 0) ? -1 : 1;
			var exponent:uint = (word >> 10) & 0x1f;
			var significand:uint = word & 0x3ff;
			if (exponent == 0) {
				if (significand == 0) {
					return 0;
				} else {
					// subnormal number
					return sign * Math.pow(2, 1 - FLOAT16_EXPONENT_BASE) * (significand / 1024);
				}
			}
			if (exponent == 31) { 
				if (significand == 0) {
					return (sign < 0) ? Number.NEGATIVE_INFINITY : Number.POSITIVE_INFINITY;
				} else {
					return Number.NaN;
				}
			}
			// normal number
			return sign * Math.pow(2, exponent - FLOAT16_EXPONENT_BASE) * (1 + significand / 1024);
		}
		
		public function writeFLOAT16(value:Number):void {
			// TODO: writeFLOAT16
			throw new Error("writeFLOAT16() not yet implemented");
		}

		/////////////////////////////////////////////////////////
		// Encoded integer
		/////////////////////////////////////////////////////////
		
		public function readEncodedU32():uint {
			resetBitsPending();
			var result:uint = readUnsignedByte();
			if (result & 0x80) {
				result = (result & 0x7f) | (readUnsignedByte() << 7);
				if (result & 0x4000) {
					result = (result & 0x3fff) | (readUnsignedByte() << 14);
					if (result & 0x200000) {
						result = (result & 0x1fffff) | (readUnsignedByte() << 21);
						if (result & 0x10000000) {
							result = (result & 0xfffffff) | (readUnsignedByte() << 28);
						}
					}
				}
			}
			return result;
		}
		
		public function writeEncodedU32(value:uint):void {
			// TODO: writeEncodedU32
			throw new Error("writeEncodedU32() not yet implemented");
		}

		/////////////////////////////////////////////////////////
		// Bit values
		/////////////////////////////////////////////////////////
		
		public function readUB(bits:uint):uint {
			return readBits(bits);
		}

		public function writeUB(bits:uint, value:uint):void {
			writeBits(bits, value);
		}

		public function readSB(bits:uint):int {
			var shift:uint = 32 - bits;
			return int(readBits(bits) << shift) >> shift;
		}
		
		public function writeSB(bits:uint, value:int):void {
			writeBits(bits, value);
		}
		
		public function readFB(bits:uint):Number {
			return Number(readSB(bits)) / 65536;
		}
		
		public function writeFB(bits:uint, value:Number):void {
			// TODO: writeFB
			throw new Error("writeFB() not yet implemented");
		}
		
		/////////////////////////////////////////////////////////
		// String
		/////////////////////////////////////////////////////////
		
		public function readString():String {
			var c:uint;
			var ba:ByteArray = new ByteArray();
			while ((c = readUnsignedByte()) != 0) {
				ba.writeByte(c);
			}
			ba.position = 0;
			resetBitsPending();
			return ba.readUTFBytes(ba.length);
		}
		
		public function writeString(value:String):void {
			if (value && value.length > 0) {
				writeUTFBytes(value);
			}
			writeByte(0);
		}
		
		/////////////////////////////////////////////////////////
		// Labguage code
		/////////////////////////////////////////////////////////
		
		public function readLANGCODE():uint {
			resetBitsPending();
			return readUnsignedByte();
		}
		
		public function writeLANGCODE(value:uint):void {
			resetBitsPending();
			writeByte(value);
		}
		
		/////////////////////////////////////////////////////////
		// Color records
		/////////////////////////////////////////////////////////
		
		public function readRGB():uint {
			resetBitsPending();
			var r:uint = readUnsignedByte();
			var g:uint = readUnsignedByte();
			var b:uint = readUnsignedByte();
			return 0xff000000 | (r << 16) | (g << 8) | b;
		}
		
		public function writeRGB(value:uint):void {
			resetBitsPending();
			writeByte((value >> 16) & 0xff);
			writeByte((value >> 8) & 0xff);
			writeByte(value  & 0xff);
		}

		public function readRGBA():uint {
			resetBitsPending();
			var rgb:uint = readRGB() & 0x00ffffff;
			var a:uint = readUnsignedByte();
			return a << 24 | rgb;
		}
		
		public function writeRGBA(value:uint):void {
			resetBitsPending();
			writeRGB(value);
			writeByte((value >> 24) & 0xff);
		}

		public function readARGB():uint {
			resetBitsPending();
			var a:uint = readUnsignedByte();
			var rgb:uint = readRGB() & 0x00ffffff;
			return (a << 24) | rgb;
		}
		
		public function writeARGB(value:uint):void {
			resetBitsPending();
			writeByte((value >> 24) & 0xff);
			writeRGB(value);
		}

		/////////////////////////////////////////////////////////
		// Rectangle record
		/////////////////////////////////////////////////////////
		
		public function readRECT():SWFRectangle {
			return new SWFRectangle(this);
		}
		
		public function writeRECT(value:SWFRectangle):void {
			value.publish(this);
		}
		
		/////////////////////////////////////////////////////////
		// Matrix record
		/////////////////////////////////////////////////////////
		
		public function readMATRIX():SWFMatrix {
			return new SWFMatrix(this);
		}
		
		public function writeMATRIX(value:SWFMatrix):void {
			// TODO: writeMATRIX
			throw new Error("writeMATRIX() not yet implemented");
		}

		/////////////////////////////////////////////////////////
		// Color transform records
		/////////////////////////////////////////////////////////
		
		public function readCXFORM():SWFColorTransform {
			return new SWFColorTransform(this);
		}
		
		public function writeCXFORM(value:SWFColorTransform):void {
			// TODO: writeCXFORM
			throw new Error("writeCXFORM() not yet implemented");
		}

		public function readCXFORMWITHALPHA():SWFColorTransformWithAlpha {
			return new SWFColorTransformWithAlpha(this);
		}
		
		public function writeCXFORMWITHALPHA(value:SWFColorTransformWithAlpha):void {
			// TODO: writeCXFORMWITHALPHA
			throw new Error("writeCXFORMWITHALPHA() not yet implemented");
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
				position--;
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
				position--;
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
		// Morphs
		/////////////////////////////////////////////////////////
		
		public function readMORPHFILLSTYLE(level:uint = 1):SWFMorphFillStyle {
			return new SWFMorphFillStyle(this, level);
		}
		
		public function readMORPHLINESTYLE(level:uint = 1):SWFMorphLineStyle {
			return new SWFMorphLineStyle(this, level);
		}
		
		public function readMORPHLINESTYLE2(level:uint = 1):SWFMorphLineStyle2 {
			return new SWFMorphLineStyle2(this, level);
		}
		
		public function readMORPHGRADIENT(level:uint = 1):SWFMorphGradient {
			return new SWFMorphGradient(this, level);
		}
		
		public function readMORPHGRADIENTRECORD(level:uint = 1):SWFMorphGradientRecord {
			return new SWFMorphGradientRecord(this, level);
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
		
		public function writeACTIONRECORD(action:IAction):void {
			action.publish(this);
		}
		
		public function readACTIONVALUE():SWFActionValue {
			return new SWFActionValue(this);
		}
		
		public function writeACTIONVALUE(value:SWFActionValue):void {
			value.publish(this);
		}
		
		public function readREGISTERPARAM():SWFRegisterParam {
			return new SWFRegisterParam(this);
		}
		
		public function writeREGISTERPARAM(value:SWFRegisterParam):void {
			value.publish(this);
		}
		
		/////////////////////////////////////////////////////////
		// Symbols
		/////////////////////////////////////////////////////////
		
		public function readSYMBOL():SWFSymbol {
			return new SWFSymbol(this);
		}
		
		public function writeSYMBOL(value:SWFSymbol):void {
			value.publish(this);
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
		// ClipEvents
		/////////////////////////////////////////////////////////
		
		public function readCLIPACTIONS(version:uint):SWFClipActions {
			return new SWFClipActions(this, version);
		}
		
		public function readCLIPACTIONRECORD(version:uint):SWFClipActionRecord {
			var pos:uint = position;
			var flags:uint = (version >= 6) ? readUI32() : readUI16();
			if (flags == 0) {
				return null;
			} else {
				position = pos;
				return new SWFClipActionRecord(this, version);
			}
		}
		
		public function readCLIPEVENTFLAGS(version:uint):SWFClipEventFlags {
			return new SWFClipEventFlags(this, version);
		}
		
		
		/////////////////////////////////////////////////////////
		// Tag header
		/////////////////////////////////////////////////////////
		
		public function readTagHeader():SWFRecordHeader {
			var tagTypeAndLength:uint = readUI16();
			var tagLength:uint = tagTypeAndLength & 0x3f;
			if (tagLength == 0x3f) {
				// The SWF10 spec sez that this is a signed int.
				// Shouldn't it be an unsigned int?
				tagLength = readSI32();
			}
			//trace("tag:" + (tagTypeAndLength >> 6) + " length:" + tagLength);
			return new SWFRecordHeader(tagTypeAndLength >> 6, tagLength);
		}

		public function writeTagHeader(type:uint, length:uint):void {
			if (length < 0x3f) {
				writeUI16((type << 6) | length);
			} else {
				writeUI16((type << 6) | 0x3f);
				// The SWF10 spec sez that this is a signed int.
				// Shouldn't it be an unsigned int?
				writeSI32(length);
			}
		}
		
		/////////////////////////////////////////////////////////
		// SWF Compression
		/////////////////////////////////////////////////////////
		
		public function swfUncompress():void {
			var pos:uint = position;
			var ba:ByteArray = new ByteArray();
			readBytes(ba);
			ba.position = 0;
			ba.uncompress();
			length = position = pos;
			writeBytes(ba);
			position = pos;
		}
		
		public function swfCompress():void {
			var pos:uint = position;
			var ba:ByteArray = new ByteArray();
			readBytes(ba);
			ba.position = 0;
			ba.compress();
			length = position = pos;
			writeBytes(ba);
		}
		
		/////////////////////////////////////////////////////////
		// etc
		/////////////////////////////////////////////////////////
		
		public function readRawTag():ByteArray {
			var raw:ByteArray;
			var pos:uint = position;
			var header:SWFRecordHeader = readTagHeader();
			if (header.length > 0) {
				raw = new ByteArray();
				readBytes(raw, 0, header.length);
			}
			position = pos;
			return raw;
		}
		
		public function skipBytes(length:uint):void {
			position += length;
		}
		
		public function dump(length:uint, offset:int = 0):void {
			var pos:uint = position;
			position += offset;
			var str:String = "bitsPending:" + bitsPending + ", ";
			for (var i:uint = 0; i < length; i++) {
				str += readUnsignedByte().toString(16) + " ";
			}
			position = pos;
			trace(str);
		}
	}
}
