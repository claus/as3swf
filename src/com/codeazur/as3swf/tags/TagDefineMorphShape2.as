package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.SWFRectangle;
	
	public class TagDefineMorphShape2 extends TagDefineMorphShape implements ITag
	{
		public static const TYPE:uint = 84;
		
		public var startEdgeBounds:SWFRectangle;
		public var endEdgeBounds:SWFRectangle;
		public var usesNonScalingStrokes:Boolean;
		public var usesScalingStrokes:Boolean;
		
		public function TagDefineMorphShape2() {}
		
		override public function parse(data:SWFData, length:uint, version:uint):void {
			characterId = data.readUI16();
			startBounds = data.readRECT();
			endBounds = data.readRECT();
			startEdgeBounds = data.readRECT();
			endEdgeBounds = data.readRECT();
			var flags:uint = data.readUI8();
			usesNonScalingStrokes = ((flags & 0x02) != 0);
			usesScalingStrokes = ((flags & 0x01) != 0);
			var offset:uint = data.readUI32();
			var i:uint;
			// MorphFillStyleArray
			var fillStyleCount:uint = data.readUI8();
			if (fillStyleCount == 0xff) {
				fillStyleCount = data.readUI16();
			}
			for (i = 0; i < fillStyleCount; i++) {
				_morphFillStyles.push(data.readMORPHFILLSTYLE());
			}
			// MorphLineStyleArray
			var lineStyleCount:uint = data.readUI8();
			if (lineStyleCount == 0xff) {
				lineStyleCount = data.readUI16();
			}
			for (i = 0; i < lineStyleCount; i++) {
				_morphLineStyles.push(data.readMORPHLINESTYLE2());
			}
			startEdges = data.readSHAPE();
			endEdges = data.readSHAPE();
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "DefineMorphShape2"; }
		override public function get version():uint { return 8; }
		
		override public function toString(indent:uint = 0):String {
			var str:String = toStringMain(indent) +
				"ID: " + characterId + ", " +
				"StartBounds: " + startBounds.toString() + ", " +
				"EndBounds: " + endBounds.toString() + ", " +
				"StartEdgeBounds: " + startEdgeBounds.toString() + ", " +
				"EndEdgeBounds: " + endEdgeBounds.toString();
			str += startEdges.toString(indent + 2);
			str += endEdges.toString(indent + 2);
			return str;
		}
	}
}
