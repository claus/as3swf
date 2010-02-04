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
			throw(new Error("TODO: implement publish()"));
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "DefineButtonCxform"; }
		
		public function toString(indent:uint = 0):String {
			var str:String = toStringMain(indent) +
				"ID: " + characterId + ", " +
				"ColorTransform: " + buttonColorTransform;
			return str;
		}
	}
}
