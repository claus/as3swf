package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.SWFRectangle;
	import com.codeazur.as3swf.data.SWFShapeWithStyle;
	import com.codeazur.as3swf.exporters.core.IShapeExporter;
	
	public class TagDefineShape extends Tag implements IDefinitionTag
	{
		public static const TYPE:uint = 2;
		
		public var shapeBounds:SWFRectangle;
		public var shapes:SWFShapeWithStyle;

		protected var _characterId:uint;
		
		public function TagDefineShape() {}
		
		public function get characterId():uint { return _characterId; }
		
		public function parse(data:SWFData, length:uint, version:uint):void {
			_characterId = data.readUI16();
			shapeBounds = data.readRECT();
			shapes = data.readSHAPEWITHSTYLE(level);
		}
		
		public function publish(data:SWFData, version:uint):void {
			var body:SWFData = new SWFData();
			body.writeUI16(characterId);
			body.writeRECT(shapeBounds);
			body.writeSHAPEWITHSTYLE(shapes, level);
			data.writeTagHeader(type, body.length);
			data.writeBytes(body);
		}
		
		public function export(handler:IShapeExporter = null):void {
			shapes.export(handler);
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "DefineShape"; }
		override public function get version():uint { return 1; }
		
		public function toString(indent:uint = 0):String {
			var str:String = toStringMain(indent) +
				"ID: " + characterId + ", " +
				"Bounds: " + shapeBounds;
			str += shapes.toString(indent + 2);
			return str;
		}
	}
}
