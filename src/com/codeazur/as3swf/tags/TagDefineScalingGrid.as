package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.SWFRectangle;
	
	public class TagDefineScalingGrid extends Tag implements IDefinitionTag
	{
		public static const TYPE:uint = 78;
		
		public var splitter:SWFRectangle;

		protected var _characterId:uint;
		
		public function TagDefineScalingGrid() {}
		
		public function get characterId():uint { return _characterId; }
		
		public function parse(data:SWFData, length:uint, version:uint):void {
			_characterId = data.readUI16();
			splitter = data.readRECT();
		}
		
		public function publish(data:SWFData, version:uint):void {
			var body:SWFData = new SWFData();
			body.writeUI16(characterId);
			body.writeRECT(splitter);
			
			data.writeTagHeader(type, body.length);
			data.writeBytes(body);
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "DefineScalingGrid"; }
		override public function get version():uint { return 8; }
		
		public function toString(indent:uint = 0):String {
			return toStringMain(indent) +
				"CharacterID: " + characterId + ", " +
				"Splitter: " + splitter;
		}
	}
}
