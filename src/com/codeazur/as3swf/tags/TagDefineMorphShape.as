package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.SWFMorphFillStyle;
	import com.codeazur.as3swf.data.SWFMorphLineStyle;
	import com.codeazur.as3swf.data.SWFRectangle;
	import com.codeazur.as3swf.data.SWFShape;
	
	public class TagDefineMorphShape extends Tag implements ITag
	{
		public static const TYPE:uint = 46;
		
		public var characterId:uint;
		public var startBounds:SWFRectangle;
		public var endBounds:SWFRectangle;
		public var startEdges:SWFShape;
		public var endEdges:SWFShape;
		
		protected var _morphFillStyles:Vector.<SWFMorphFillStyle>;
		protected var _morphLineStyles:Vector.<SWFMorphLineStyle>;
		
		public function TagDefineMorphShape() {
			_morphFillStyles = new Vector.<SWFMorphFillStyle>();
			_morphLineStyles = new Vector.<SWFMorphLineStyle>();
		}
		
		public function get morphFillStyles():Vector.<SWFMorphFillStyle> { return _morphFillStyles; }
		public function get morphLineStyles():Vector.<SWFMorphLineStyle> { return _morphLineStyles; }
		
		public function parse(data:SWFData, length:uint, version:uint):void {
			characterId = data.readUI16();
			startBounds = data.readRECT();
			endBounds = data.readRECT();
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
				_morphLineStyles.push(data.readMORPHLINESTYLE());
			}
			startEdges = data.readSHAPE();
			endEdges = data.readSHAPE();
		}
		
		public function publish(data:SWFData, version:uint):void {
			throw(new Error("TODO: implement publish()"));
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "DefineMorphShape"; }
		override public function get version():uint { return 3; }
		
		public function toString(indent:uint = 0):String {
			var str:String = toStringMain(indent) +
				"ID: " + characterId + ", " +
				"StartBounds: " + startBounds.toString() + ", " +
				"EndBounds: " + endBounds.toString();
			str += startEdges.toString(indent + 2);
			str += endEdges.toString(indent + 2);
			return str;
		}
	}
}
