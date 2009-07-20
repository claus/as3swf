﻿package com.codeazur.as3swf.data
{
	import com.codeazur.as3swf.ISWFDataInput;
	
	public class SWFFillStyle
	{
		public var type:uint;

		public var rgb:uint;
		public var gradient:SWFGradient;
		public var gradientMatrix:SWFMatrix;
		public var bitmapId:uint;
		public var bitmapMatrix:SWFMatrix;
		
		public function SWFFillStyle(data:ISWFDataInput = null, level:uint = 1) {
			if (data != null) {
				parse(data, level);
			}
		}
		
		public function parse(data:ISWFDataInput, level:uint = 1):void {
			type = data.readUI8();
			switch(type) {
				case 0x00:
					rgb = (level <= 2) ? data.readRGB() : data.readRGBA();
					break;
				case 0x10:
				case 0x12:
				case 0x13:
					gradientMatrix = data.readMATRIX();
					gradient = (type == 0x13) ? data.readFOCALGRADIENT(level) : data.readGRADIENT(level);
					break;
				case 0x40:
				case 0x41:
				case 0x42:
				case 0x43:
					bitmapId = data.readUI16();
					bitmapMatrix = data.readMATRIX();
					break;
				default:
					throw(new Error("Unknown fill style type: 0x" + type.toString(16)));
			}
		}
		
		public function toString():String {
			var str:String = "[SWFFillStyle] Type: " + type.toString(16);
			switch(type) {
				case 0x00: str += " (solid), Color: " + rgb.toString(16); break;
				case 0x10: str += " (linear gradient), Gradient: " + gradient; break;
				case 0x12: str += " (radial gradient), Gradient: " + gradient; break;
				case 0x13: str += " (focal radial gradient), Gradient: " + gradient; break;
				case 0x40: str += " (repeating bitmap), BitmapID: " + bitmapId; break;
				case 0x41: str += " (clipped bitmap), BitmapID: " + bitmapId; break;
				case 0x42: str += " (non-smoothed repeating bitmap), BitmapID: " + bitmapId; break;
				case 0x43: str += " (non-smoothed clipped bitmap), BitmapID: " + bitmapId; break;
			}
			return str;
		}
	}
}
