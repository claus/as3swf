package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	
	public class TagProductInfo extends Tag implements ITag
	{
		public static const TYPE:uint = 41;
		
		public var productId:uint;
		public var edition:uint;
		public var majorVersion:uint;
		public var minorVersion:uint;
		public var majorBuild:uint;
		public var minorBuild:uint;
		public var compileDate:Date;
		
		public function TagProductInfo() {}
		
		public function parse(data:SWFData, length:uint, version:uint):void {
			productId = data.readUI32();
			edition = data.readUI32();
			majorVersion = data.readUI8();
			minorVersion = data.readUI8();
			minorBuild = data.readUI32();
			majorBuild = data.readUI32();
			var sec:Number = data.readUI32();
			sec += data.readUI32() * 4294967296;
			compileDate = new Date(sec);
		}
		
		public function publish(data:SWFData, version:uint):void {
			throw(new Error("TODO: implement publish()"));
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "ProductInfo"; }
		override public function get version():uint { return 3; }
		
		public function toString(indent:uint = 0):String {
			return toStringMain(indent) +
				"ProductID: " + productId + ", " +
				"Edition: " + edition + ", " +
				"Version: " + majorVersion + "." + minorVersion + "." + majorBuild + "." + minorBuild + ", " +
				"CompileDate: " + compileDate.toString();
		}
	}
}
