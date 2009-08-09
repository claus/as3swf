package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	
	public class TagScriptLimits extends Tag implements ITag
	{
		public static const TYPE:uint = 65;
		
		public var maxRecursionDepth:uint;
		public var scriptTimeoutSeconds:uint;
		
		public function TagScriptLimits() {}
		
		public function parse(data:SWFData, length:uint, version:uint):void {
			maxRecursionDepth = data.readUI16();
			scriptTimeoutSeconds = data.readUI16();
		}
		
		public function publish(data:SWFData, version:uint):void {
			data.writeTagHeader(type, 4);
			data.writeUI16(maxRecursionDepth);
			data.writeUI16(scriptTimeoutSeconds);
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "ScriptLimits"; }
		override public function get version():uint { return 7; }
		
		public function toString(indent:uint = 0):String {
			return toStringMain(indent) +
				"MaxRecursionDepth: " + maxRecursionDepth + ", " +
				"ScriptTimeoutSeconds: " + scriptTimeoutSeconds;
		}
	}
}
