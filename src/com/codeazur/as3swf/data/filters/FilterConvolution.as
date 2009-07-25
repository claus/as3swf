package com.codeazur.as3swf.data.filters
{
	import com.codeazur.as3swf.SWFData;
	
	public class FilterConvolution extends Filter implements IFilter
	{
		public var matrixX:uint;
		public var matrixY:uint;
		public var divisor:Number;
		public var bias:Number;
		public var defaultColor:uint;
		public var clamp:Boolean;
		public var preserveAlpha:Boolean;
		
		protected var _matrix:Vector.<Number>;
		
		public function FilterConvolution(id:uint) {
			super(id);
			_matrix = new Vector.<Number>();
		}
		
		public function get matrix():Vector.<Number> { return _matrix; }

		override public function parse(data:SWFData):void {
			matrixX = data.readUI8();
			matrixY = data.readUI8();
			divisor = data.readFLOAT();
			bias = data.readFLOAT();
			var len:uint = matrixX * matrixY;
			for (var i:uint = 0; i < len; i++) {
				_matrix.push(data.readFLOAT);
			}
			defaultColor = data.readRGBA();
			var flags:uint = data.readUI8();
			clamp = ((flags & 0x02) != 0);
			preserveAlpha = ((flags & 0x01) != 0);
		}
	}
}
