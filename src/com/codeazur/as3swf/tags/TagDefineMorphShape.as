package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.SWFMorphFillStyle;
	import com.codeazur.as3swf.data.SWFMorphLineStyle;
	import com.codeazur.as3swf.data.SWFRectangle;
	import com.codeazur.as3swf.data.SWFShape;
	import com.codeazur.utils.StringUtils;
	
	public class TagDefineMorphShape extends Tag implements IDefinitionTag
	{
		public static const TYPE:uint = 46;
		
		public var startBounds:SWFRectangle;
		public var endBounds:SWFRectangle;
		public var startEdges:SWFShape;
		public var endEdges:SWFShape;
		
		protected var _characterId:uint;
		protected var _morphFillStyles:Vector.<SWFMorphFillStyle>;
		protected var _morphLineStyles:Vector.<SWFMorphLineStyle>;
		
		public function TagDefineMorphShape() {
			_morphFillStyles = new Vector.<SWFMorphFillStyle>();
			_morphLineStyles = new Vector.<SWFMorphLineStyle>();
		}
		
		public function get characterId():uint { return _characterId; }
		public function get morphFillStyles():Vector.<SWFMorphFillStyle> { return _morphFillStyles; }
		public function get morphLineStyles():Vector.<SWFMorphLineStyle> { return _morphLineStyles; }
		
		public function parse(data:SWFData, length:uint, version:uint):void {
			_characterId = data.readUI16();
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
			var body:SWFData = new SWFData();
			body.writeUI16(characterId);
			body.writeRECT(startBounds);
			body.writeRECT(endBounds);
			var startBytes:SWFData = new SWFData();
			var i:uint;
			// MorphFillStyleArray
			var fillStyleCount:uint = _morphFillStyles.length;
			if (fillStyleCount > 0xfe) {
				startBytes.writeUI8(0xff);
				startBytes.writeUI16(fillStyleCount);
			} else {
				startBytes.writeUI8(fillStyleCount);
			}
			for (i = 0; i < fillStyleCount; i++) {
				startBytes.writeMORPHFILLSTYLE(_morphFillStyles[i])
			}
			// MorphLineStyleArray
			var lineStyleCount:uint = _morphLineStyles.length;
			if (lineStyleCount > 0xfe) {
				startBytes.writeUI8(0xff);
				startBytes.writeUI16(lineStyleCount);
			} else {
				startBytes.writeUI8(lineStyleCount);
			}
			for (i = 0; i < lineStyleCount; i++) {
				startBytes.writeMORPHLINESTYLE(_morphLineStyles[i])
			}
			startBytes.writeSHAPE(startEdges);
			body.writeUI32(startBytes.length);
			body.writeBytes(startBytes);
			body.writeSHAPE(endEdges);
			data.writeTagHeader(type, body.length);
			data.writeBytes(body);
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "DefineMorphShape"; }
		override public function get version():uint { return 3; }
		
		public function toString(indent:uint = 0):String {
			var i:uint;
			var indent2:String = StringUtils.repeat(indent + 2);
			var indent4:String = StringUtils.repeat(indent + 4);
			var str:String = toStringMain(indent) + "ID: " + characterId;
			str += "\n" + indent2 + "Bounds:";
			str += "\n" + indent4 + "StartBounds: " + startBounds.toString();
			str += "\n" + indent4 + "EndBounds: " + endBounds.toString();
			if(_morphFillStyles.length > 0) {
				str += "\n" + indent2 + "FillStyles:";
				for(i = 0; i < _morphFillStyles.length; i++) {
					str += "\n" + indent4 + "[" + (i + 1) + "] " + _morphFillStyles[i].toString();
				}
			}
			if(_morphLineStyles.length > 0) {
				str += "\n" + indent2 + "LineStyles:";
				for(i = 0; i < _morphLineStyles.length; i++) {
					str += "\n" + indent4 + "[" + (i + 1) + "] " + _morphLineStyles[i].toString();
				}
			}
			str += startEdges.toString(indent + 2);
			str += endEdges.toString(indent + 2);
			return str;
		}
	}
}
