package com.codeazur.as3swf.data
{
	import com.codeazur.utils.StringUtils;
	
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
		
		override public function toString(indent:uint = 0):String {
			var i:uint;
			var str:String = "";
			if (_fillStyles.length > 0) {
				str += "\n" + StringUtils.repeat(indent) + "FillStyles:";
				for (i = 0; i < _fillStyles.length; i++) {
					str += "\n" + StringUtils.repeat(indent + 2) + "[" + i + "] " + _fillStyles[i].toString();
				}
			}
			if (_lineStyles.length > 0) {
				str += "\n" + StringUtils.repeat(indent) + "LineStyles:";
				for (i = 0; i < _lineStyles.length; i++) {
					str += "\n" + StringUtils.repeat(indent + 2) + "[" + i + "] " + _lineStyles[i].toString();
				}
			}
			return str + super.toString(indent);
		}
	}
}
