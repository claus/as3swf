package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.SWFColorTransform;
	
	public class TagDefineButtonCxform extends Tag implements IDefinitionTag
	{
		public static const TYPE:uint = 23;
		
		public var buttonColorTransform:SWFColorTransform;

		protected var _characterId:uint;

		public function TagDefineButtonCxform() {}
		
		public function get characterId():uint { return _characterId; }

		public function parse(data:SWFData, length:uint, version:uint):void {
			_characterId = data.readUI16();
			buttonColorTransform = data.readCXFORM();
		}
		
		public function publish(data:SWFData, version:uint):void {
			var body:SWFData = new SWFData();
			body.writeUI16(characterId);
			body.writeCXFORM(buttonColorTransform);
			data.writeTagHeader(type, body.length);
			data.writeBytes(body);
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "DefineButtonCxform"; }
		override public function get version():uint { return 2; }
		
		public function toString(indent:uint = 0):String {
			var str:String = toStringMain(indent) +
				"ID: " + characterId + ", " +
				"ColorTransform: " + buttonColorTransform;
			return str;
		}
	}
}
