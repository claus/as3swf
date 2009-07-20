package com.codeazur.as3swf.data
{
	import com.codeazur.as3swf.ISWFDataInput;
	
	public class SWFSymbol
	{
		public var tagId:uint;
		public var name:String;
		
		public function SWFSymbol(data:ISWFDataInput = null) {
			if (data != null) {
				parse(data);
			}
		}

		public function parse(data:ISWFDataInput):void {
			tagId = data.readUI16();
			name = data.readString();
		}
		
		public function toString():String {
			return "TagID: " + tagId + ", Name: " + name;
		}
	}
}
