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
			bitsPending = 0;
			return data.readByte();
		}
		
		public function readSI16():int {
			bitsPending = 0;
			return data.readShort();
		}
		
		public function readSI32():int {
			bitsPending = 0;
			return data.readInt();
		}
		
		public function readUI8():uint {
			bitsPending = 0;
			return data.readUnsignedByte();
		}
		
		public function readUI16():uint {
			bitsPending = 0;
			return data.readUnsignedShort();
		}
		
		public function readUI24():uint {
			bitsPending = 0;
			var loWord:uint = data.readUnsignedShort();
			var hiByte:uint = data.readUnsignedByte();
			return loWord | (hiByte << 16);
		}
		
		public function readUI32():uint {
			bitsPending = 0;
			return data.readUnsignedInt();
		}
		
		/////////////////////////////////////////////////////////
		// Fixed-point numbers
		/////////////////////////////////////////////////////////
		
		public function readFIXED():Number {
			bitsPending = 0;
			var fractional:Number = data.readUnsignedShort();
			var integral:Number = data.readUnsignedShort();
			return integral + fractional / 65536;
		}
		
		public function readFIXED8():Number {
			bitsPending = 0;
			var fractional:Number = data.readUnsignedByte();
			var integral:Number = data.readUnsignedByte();
			return integral + fractional / 256;
		}
		
		/////////////////////////////////////////////////////////
		// Floating-point numbers
		/////////////////////////////////////////////////////////
		
		public function readFLOAT():Number {
			bitsPending = 0;
			return data.readFloat();
		}
		
		public function readFLOAT16():Number {
			bitsPending = 0;
			var word:uint = data.readUnsignedShort();
			var exp:uint = (word >> 10) & 0x1f;
			var man:uint = (word & 0x3FF);
			return ((word & 0x8000) ? man : -man) * Math.pow(2, exp - 16);
		}
		
		public function readDOUBLE():Number {
			bitsPending = 0;
			return data.readDouble();
		}
		
		/////////////////////////////////////////////////////////
		// Encoded integer
		/////////////////////////////////////////////////////////
		
		public function readEncodedU32():uint {
			bitsPending = 0;
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
			bitsPending = 0;
			return ba.readUTFBytes(ba.length);
		}
		
		/////////////////////////////////////////////////////////
		// Labguage code
		/////////////////////////////////////////////////////////
		
		public function readLANGCODE():uint {
			bitsPending = 0;
			return data.readUnsignedByte();
		}
		
		/////////////////////////////////////////////////////////
		// Color records
		/////////////////////////////////////////////////////////
		
		public function readRGB():uint {
			bitsPending = 0;
			var r:uint = data.readUnsignedByte();
			var g:uint = data.readUnsignedByte();
			var b:uint = data.readUnsignedByte();
			return 0xff000000 | (r << 16) | (g << 8) | b;
		}
		
		public function readRGBA():uint {
			bitsPending = 0;
			var rgb:uint = readRGB();
			var a:uint = data.readUnsignedByte();
			return (a << 24) | rgb;
		}
		
		public function readARGB():uint {
			bitsPending = 0;
			var a:uint = data.readUnsignedByte();
			var rgb:uint = readRGB();
			return (a << 24) | rgb;
		}
		
		/////////////////////////////////////////////////////////
		// Rectangle record
		/////////////////////////////////////////////////////////
		
		public function readRECT():SWFRectangle {
			bitsPending = 0;
			var bits:uint = readUB(5);
			var xmin:int = readSB(bits);
			var xmax:int = readSB(bits);
			var ymin:int = readSB(bits);
			var ymax:int = readSB(bits);
			return new SWFRectangle(xmin, xmax, ymin, ymax);
		}
		
		/////////////////////////////////////////////////////////
		// Matrix record
		/////////////////////////////////////////////////////////
		
		public function readMATRIX():SWFMatrix {
			bitsPending = 0;
			var scaleX:Number = 1.0;
			var scaleY:Number = 1.0;
			if (readUB(1) == 1) {
				var scaleBits:uint = readUB(5);
				scaleX = readFB(scaleBits);
				scaleY = readFB(scaleBits);
			}
			var rotateSkew0:Number = 0.0;
			var rotateSkew1:Number = 0.0;
			if (readUB(1) == 1) {
				var rotateBits:uint = readUB(5);
				rotateSkew0 = readFB(rotateBits);
				rotateSkew1 = readFB(rotateBits);
			}
			var translateBits:uint = readUB(5);
			var translateX:int = readSB(translateBits);
			var translateY:int = readSB(translateBits);
			return new SWFMatrix(scaleX, scaleY, rotateSkew0, rotateSkew1, translateX, translateY);
		}
		
		/////////////////////////////////////////////////////////
		// Color transform records
		/////////////////////////////////////////////////////////
		
		public function readCXFORM():SWFColorTransform {
			bitsPending = 0;
			var hasAddTerms:uint = readUB(1);
			var hasMultTerms:uint = readUB(1);
			var bits:uint = readUB(4);
			var rMult:int = 1;
			var gMult:int = 1;
			var bMult:int = 1;
			if (hasMultTerms == 1) {
				rMult = readSB(bits);
				gMult = readSB(bits);
				bMult = readSB(bits);
			}
			var rAdd:int = 0;
			var gAdd:int = 0;
			var bAdd:int = 0;
			if (hasAddTerms == 1) {
				rAdd = readSB(bits);
				gAdd = readSB(bits);
				bAdd = readSB(bits);
			}
			return new SWFColorTransform(rMult, gMult, bMult, rAdd, gAdd, bAdd);
		}
		
		public function readCXFORMWITHALPHA():SWFColorTransformWithAlpha {
			bitsPending = 0;
			var hasAddTerms:uint = readUB(1);
			var hasMultTerms:uint = readUB(1);
			var bits:uint = readUB(4);
			var rMult:int = 1;
			var gMult:int = 1;
			var bMult:int = 1;
			var aMult:int = 1;
			if (hasMultTerms == 1) {
				rMult = readSB(bits);
				gMult = readSB(bits);
				bMult = readSB(bits);
				aMult = readSB(bits);
			}
			var rAdd:int = 0;
			var gAdd:int = 0;
			var bAdd:int = 0;
			var aAdd:int = 0;
			if (hasAddTerms == 1) {
				rAdd = readSB(bits);
				gAdd = readSB(bits);
				bAdd = readSB(bits);
				aAdd = readSB(bits);
			}
			return new SWFColorTransformWithAlpha(rMult, gMult, bMult, rAdd, gAdd, bAdd, aMult, aAdd);
		}
		
		
		/////////////////////////////////////////////////////////
		// Shape and shape records
		/////////////////////////////////////////////////////////
		
		public function readSHAPE():SWFShape {
			bitsPending = 0;
			var numFillBits:uint = readUB(4);
			var numLineBits:uint = readUB(4);
			var shape:SWFShape = new SWFShape();
			readShapeRecords(shape, numFillBits, numLineBits);
			return shape;
		}
		
		public function readSHAPEWITHSTYLE(level:uint = 1):SWFShapeWithStyle {
			bitsPending = 0;
			var i:uint;
			var shape:SWFShapeWithStyle = new SWFShapeWithStyle();
			var fillStylesLen:uint = readStyleArrayLength(level);
			for (i = 0; i < fillStylesLen; i++) {
				shape.fillStyles.push(readFILLSTYLE(level));
			}
			var lineStylesLen:uint = readStyleArrayLength(level);
			for (i = 0; i < lineStylesLen; i++) {
				shape.lineStyles.push(level <= 3 ? readLINESTYLE(level) : readLINESTYLE2(level));
			}
			var numFillBits:uint = readUB(4);
			var numLineBits:uint = readUB(4);
			bitsPending = 0;
			readShapeRecords(shape, numFillBits, numLineBits, level);
			return shape;
		}

		protected function readShapeRecords(shape:SWFShape, fillBits:uint, lineBits:uint, level:uint = 1):void {
			var shapeRecord:SWFShapeRecord;
			while (!(shapeRecord is SWFShapeRecordEnd)) {
				// The SWF10 spec says that shape records are byte aligned.
				// In reality they seem not to be?
				// bitsPending = 0;
				var edgeRecord:Boolean = (readUB(1) == 1);
				if (edgeRecord) {
					var straightFlag:Boolean = (readUB(1) == 1);
					var numBits:uint = readUB(4) + 2;
					if (straightFlag) {
						shapeRecord = readSTRAIGHTEDGERECORD(numBits);
					} else {
						shapeRecord = readCURVEDEDGERECORD(numBits);
					}
				} else {
					var states:uint = readUB(5);
					if (states == 0) {
						shapeRecord = new SWFShapeRecordEnd();
					} else {
						var styleChangeRecord:SWFShapeRecordStyleChange = readSTYLECHANGERECORD(states, fillBits, lineBits, level);
						if (styleChangeRecord.stateNewStyles) {
							// TODO: We might have to update fillStyles and lineStyles too
							fillBits = styleChangeRecord.numFillBits;
							lineBits = styleChangeRecord.numLineBits;
						}
						shapeRecord = styleChangeRecord;
					}
				}
				shape.records.push(shapeRecord);
				//trace(shapeRecord);
			}
		}
		
		protected function readSTRAIGHTEDGERECORD(numBits:uint):SWFShapeRecordStraightEdge {
			var generalLineFlag:Boolean = (readUB(1) == 1);
			var vertLineFlag:Boolean = !generalLineFlag ? (readSB(1) != 0) : false;
			var deltaX:int = (generalLineFlag || !vertLineFlag) ? readSB(numBits) : 0;
			var deltaY:int = (generalLineFlag || vertLineFlag) ? readSB(numBits) : 0;
			return new SWFShapeRecordStraightEdge(generalLineFlag, vertLineFlag, deltaX, deltaY);
		}
		
		protected function readCURVEDEDGERECORD(numBits:uint):SWFShapeRecordCurvedEdge {
			var controlDeltaX:int = readSB(numBits);
			var controlDeltaY:int = readSB(numBits);
			var anchorDeltaX:int = readSB(numBits);
			var anchorDeltaY:int = readSB(numBits);
			return new SWFShapeRecordCurvedEdge(controlDeltaX, controlDeltaY, anchorDeltaX, anchorDeltaY);
		}
		
		protected function readSTYLECHANGERECORD(states:uint, fillBits:uint, lineBits:uint, level:uint = 1):SWFShapeRecordStyleChange {
			var record:SWFShapeRecordStyleChange = new SWFShapeRecordStyleChange(states);
			if (record.stateMoveTo) {
				var moveBits:uint = readUB(5);
				record.moveDeltaX = readSB(moveBits);
				record.moveDeltaY = readSB(moveBits);
			}
			record.fillStyle0 = record.stateFillStyle0 ? readUB(fillBits) : 0;
			record.fillStyle1 = record.stateFillStyle1 ? readUB(fillBits) : 0;
			record.lineStyle = record.stateLineStyle ? readUB(lineBits) : 0;
			if (record.stateNewStyles) {
				bitsPending = 0;
				var i:uint;
				var fillStylesLen:uint = readStyleArrayLength(level);
				for (i = 0; i < fillStylesLen; i++) {
					record.fillStyles.push(readFILLSTYLE(level));
				}
				var lineStylesLen:uint = readStyleArrayLength(level);
				for (i = 0; i < lineStylesLen; i++) {
					record.lineStyles.push(level <= 3 ? readLINESTYLE(level) : readLINESTYLE2(level));
				}
				record.numFillBits = readUB(4);
				record.numLineBits = readUB(4);
			}
			return record;
		}
		
		protected function readStyleArrayLength(level:uint = 1):uint {
			var len:uint = readUI8();
			if (level >= 2 && len == 0xff) {
				len = readUI16();
			}
			return len;
		}

		
		/////////////////////////////////////////////////////////
		// Fill- and Linestyles
		/////////////////////////////////////////////////////////
		
		public function readFILLSTYLE(level:uint = 1):SWFFillStyle {
			var fillStyleType:uint = readUI8();
			var fillStyle:SWFFillStyle = new SWFFillStyle(fillStyleType);
			switch(fillStyleType) {
				case 0x00:
					fillStyle.rgb = (level <= 2) ? readRGB() : readRGBA();
					break;
				case 0x10:
				case 0x12:
				case 0x13:
					fillStyle.gradientMatrix = readMATRIX();
					fillStyle.gradient = (fillStyleType == 0x13) ? readFOCALGRADIENT(level) : readGRADIENT(level);
					break;
				case 0x40:
				case 0x41:
				case 0x42:
				case 0x43:
					fillStyle.bitmapId = readUI16();
					fillStyle.bitmapMatrix = readMATRIX();
					break;
				default:
					throw(new Error("Unknown fill style type: 0x" + fillStyleType.toString(16)));
			}
			return fillStyle;
		}
		
		public function readLINESTYLE(level:uint = 1):SWFLineStyle {
			var width:uint = readUI16();
			var lineStyle:SWFLineStyle = new SWFLineStyle(width);
			lineStyle.color = (level <= 2) ? readRGB() : readRGBA();
			return lineStyle;
		}
		
		public function readLINESTYLE2(level:uint = 1):SWFLineStyle2 {
			var width:uint = readUI16();
			var lineStyle:SWFLineStyle2 = new SWFLineStyle2(width);
			lineStyle.startCapStyle = readUB(2);
			lineStyle.joinStyle = readUB(2);
			lineStyle.hasFillFlag = (readUB(1) == 1);
			lineStyle.noHScaleFlag = (readUB(1) == 1);
			lineStyle.noVScaleFlag = (readUB(1) == 1);
			lineStyle.pixelHintingFlag = (readUB(1) == 1);
			var reserved:uint = readUB(5);
			lineStyle.noClose = (readUB(1) == 1);
			lineStyle.endCapStyle = readUB(2);
			if (lineStyle.joinStyle) {
				lineStyle.miterLimitFactor = readFIXED8();
			}
			if (lineStyle.hasFillFlag) {
				lineStyle.fillType = readFILLSTYLE(level);
			} else {
				lineStyle.color = readRGBA();
			}
			return lineStyle;
		}
		
		/////////////////////////////////////////////////////////
		// Button record
		/////////////////////////////////////////////////////////
		
		public function readBUTTONRECORD(level:uint = 1):SWFButtonRecord {
			var flags:uint = readUI8();
			if (flags == 0) {
				return null;
			}
			var record:SWFButtonRecord = new SWFButtonRecord(flags);
			record.characterId = readUI16();
			record.placeDepth = readUI16();
			record.placeMatrix = readMATRIX();
			if (level >= 2) {
				record.colorTransform = readCXFORMWITHALPHA();
				if (record.hasFilterList) {
					var numberOfFilters:uint = readUI8();
					for (var i:uint = 0; i < numberOfFilters; i++) {
						record.filterList.push(readFILTER())
					}
				}
				if (record.hasBlendMode) {
					record.blendMode = readUI8();
				}
			}
			return record;
		}

		public function readBUTTONCONDACTION(level:uint = 1):SWFButtonCondAction {
			var condActionSize:uint = readUI16();
			var flags:uint = (readUI8() << 8) | readUI8();
			var condAction:SWFButtonCondAction = new SWFButtonCondAction(condActionSize, flags);
			var action:IAction;
			while ((action = readACTIONRECORD()) != null) {
				condAction.actions.push(action);
			}
			return condAction;
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
			var styles:uint = readUI8();
			if (styles == 0) {
				return null;
			}
			var record:SWFTextRecord = new SWFTextRecord(styles);
			if (record.hasFont) {
				record.fontId = readUI16();
			} else if (previousRecord != null) {
				record.fontId = previousRecord.fontId;
			}
			if (record.hasColor) {
				record.textColor = (level < 2) ? readRGB() : readRGBA();
			} else if (previousRecord != null) {
				record.textColor = previousRecord.textColor;
			}
			if (record.hasXOffset) {
				record.xOffset = readSI16();
			} else if (previousRecord != null) {
				record.xOffset = previousRecord.xOffset;
			}
			if (record.hasYOffset) {
				record.yOffset = readSI16();
			} else if (previousRecord != null) {
				record.yOffset = previousRecord.yOffset;
			}
			if (record.hasFont) {
				record.textHeight = readUI16();
			} else if (previousRecord != null) {
				record.textHeight = previousRecord.textHeight;
			}
			var glyphCount:uint = readUI8();
			for (var i:uint = 0; i < glyphCount; i++) {
				record.glyphEntries.push(readGLYPHENTRY(glyphBits, advanceBits));
			}
			return record;
		}

		public function readGLYPHENTRY(glyphBits:uint, advanceBits:uint):SWFGlyphEntry {
			// GLYPHENTRYs are not byte aligned
			var glyphIndex:uint = readUB(glyphBits);
			var glyphAdvance:uint = readSB(advanceBits);
			return new SWFGlyphEntry(glyphIndex, glyphAdvance);
		}

		/////////////////////////////////////////////////////////
		// Zone record
		/////////////////////////////////////////////////////////
		
		public function readZONERECORD():SWFZoneRecord {
			var numZoneData:uint = readUI8();
			var record:SWFZoneRecord = new SWFZoneRecord();
			for (var i:uint = 0; i < numZoneData; i++) {
				record.data.push(readZONEDATA());
			}
			var mask:uint = readUI8();
			record.maskX = (mask & 1) != 0;
			record.maskY = (mask & 2) != 0;
			return record;
		}

		public function readZONEDATA():SWFZoneData {
			var alignmentCoordinate:Number = readFLOAT16();
			var range:Number = readFLOAT16();
			return new SWFZoneData(alignmentCoordinate, range);
		}

		/////////////////////////////////////////////////////////
		// Kerning record
		/////////////////////////////////////////////////////////
		
		public function readKERNINGRECORD(wideCodes:Boolean):SWFKerningRecord {
			var kerningCode1:uint = wideCodes ? readUI16() : readUI8();
			var kerningCode2:uint = wideCodes ? readUI16() : readUI8();
			var kerningAdjustment:int = readSI16();
			return new SWFKerningRecord(kerningCode1, kerningCode2, kerningAdjustment);
		}

		/////////////////////////////////////////////////////////
		// Gradients
		/////////////////////////////////////////////////////////
		
		public function readGRADIENT(level:uint = 1):SWFGradient {
			bitsPending = 0;
			var spreadMethod:uint = readUB(2);
			var interpolationMethod:uint = readUB(2);
			var gradient:SWFGradient = new SWFGradient(spreadMethod, interpolationMethod);
			var numGradients:uint = readUB(4);
			for (var i:uint = 0; i < numGradients; i++) {
				gradient.records.push(readGRADIENTRECORD(level));
			}
			return gradient;
		}
		
		public function readFOCALGRADIENT(level:uint = 1):SWFGradient {
			var gradient:SWFGradient = readGRADIENT(level);
			gradient.focalPoint = readFIXED8();
			return gradient;
		}
		
		public function readGRADIENTRECORD(level:uint = 1):SWFGradientRecord {
			var ratio:uint = readUI8();
			var color:uint = (level <= 2) ? readRGB() : readRGBA();
			return new SWFGradientRecord(ratio, color);
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
			var actionType:uint = readUI8();
			var actionValue:SWFActionValue = new SWFActionValue(actionType);
			switch (actionType) {
				case SWFActionValue.TYPE_STRING: actionValue.string = readString(); break;
				case SWFActionValue.TYPE_FLOAT: actionValue.number = readFLOAT(); break;
				case SWFActionValue.TYPE_NULL: break;
				case SWFActionValue.TYPE_UNDEFINED: break;
				case SWFActionValue.TYPE_REGISTER: actionValue.register = readUI8(); break;
				case SWFActionValue.TYPE_BOOLEAN: actionValue.boolean = (readUI8() != 0); break;
				case SWFActionValue.TYPE_DOUBLE: actionValue.number = readDOUBLE(); break;
				case SWFActionValue.TYPE_INTEGER: actionValue.integer = readUI32(); break;
				case SWFActionValue.TYPE_CONSTANT_8: actionValue.constant = readUI8(); break;
				case SWFActionValue.TYPE_CONSTANT_16: actionValue.constant = readUI16(); break;
				default:
					throw(new Error("Unknown ActionValue type: " + actionType));
			}
			return actionValue;
		}
		
		public function readREGISTERPARAM():SWFRegisterParam {
			var register:uint = readUI8();
			var name:String = readString();
			return new SWFRegisterParam(register, name);
		}
		
		
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
