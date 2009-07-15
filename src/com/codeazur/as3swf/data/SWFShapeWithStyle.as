package com.codeazur.as3swf.data
{
	public class SWFShapeWithStyle extends SWFShape
	{
		protected var _fillStyles:Vector.<SWFFillStyle>;
		protected var _lineStyles:Vector.<SWFLineStyle>;
		
		public function SWFShapeWithStyle()
		{
			_fillStyles = new Vector.<SWFFillStyle>();
			_lineStyles = new Vector.<SWFLineStyle>();
		}
		
		public function get fillStyles():Vector.<SWFFillStyle> { return _fillStyles; }
		public function get lineStyles():Vector.<SWFLineStyle> { return _lineStyles; }
	}
}
