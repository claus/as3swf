package com.codeazur.as3swf.data.filters
{
	import com.codeazur.as3swf.ISWFDataInput;
	
	public class FilterColorMatrix extends Filter implements IFilter
	{
		protected var _colorMatrix:Vector.<Number>;
		
		public function FilterColorMatrix(id:uint) {
			super(id);
			_colorMatrix = new Vector.<Number>(20, true);
		}
		
		public function get colorMatrix():Vector.<Number> { return _colorMatrix; }

		override public function parse(data:ISWFDataInput):void {
			for (var i:uint = 0; i < 20; i++) {
				_colorMatrix.push(data.readFLOAT);
			}
		}
	}
}
