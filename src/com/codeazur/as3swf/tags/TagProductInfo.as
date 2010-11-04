package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	
	public class TagProductInfo extends Tag implements ITag
	{
		public static const TYPE:uint = 41;
		
		private static const UINT_MAX_CARRY:Number = uint.MAX_VALUE + 1;

		public var productId:uint;
		public var edition:uint;
		public var majorVersion:uint;
		public var minorVersion:uint;
		public var build:Number;
		public var compileDate:Date;
		
		public function TagProductInfo() {}
		
		public function parse(data:SWFData, length:uint, version:uint):void {
			productId = data.readUI32();
			edition = data.readUI32();
			majorVersion = data.readUI8();
			minorVersion = data.readUI8();

			build = data.readUI32()
					+ data.readUI32() * UINT_MAX_CARRY;

			var sec:Number = data.readUI32()
					+ data.readUI32() * UINT_MAX_CARRY;

			compileDate = new Date(sec);
		}
		
		public function publish(data:SWFData, version:uint):void {
			var body:SWFData = new SWFData();
			body.writeUI32(productId);
			body.writeUI32(edition);
			body.writeUI8(majorVersion);
			body.writeUI8(minorVersion);
			body.writeUI32(build);
			body.writeUI32(build / UINT_MAX_CARRY);
			body.writeUI32(compileDate.time);
			body.writeUI32(compileDate.time / UINT_MAX_CARRY);
			data.writeTagHeader(type, body.length);
			data.writeBytes(body);
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "ProductInfo"; }
		override public function get version():uint { return 3; }
		
		public function toString(indent:uint = 0):String {
			return toStringMain(indent) +
				"ProductID: " + productId + ", " +
				"Edition: " + edition + ", " +
				"Version: " + majorVersion + "." + minorVersion + " r" + build + ", " +
				"CompileDate: " + compileDate.toString();
		}
	}
}
