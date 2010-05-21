package com.codeazur.as3swf.data.filters
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.utils.StringUtils;
	
	public class FilterColorMatrix extends Filter implements IFilter
	{
		protected var _colorMatrix:Vector.<Number>;
		
		public function FilterColorMatrix(id:uint) {
			super(id);
			_colorMatrix = new Vector.<Number>();
		}
		
		public function get colorMatrix():Vector.<Number> { return _colorMatrix; }

		override public function parse(data:SWFData):void {
			for (var i:uint = 0; i < 20; i++) {
				colorMatrix.push(data.readFLOAT());
			}
		}
		
		override public function publish(data:SWFData):void {
			for (var i:uint = 0; i < 20; i++) {
				data.writeFLOAT(colorMatrix[i]);
			}
		}
		
		override public function toString(indent:uint = 0):String {
			var si:String = StringUtils.repeat(indent + 2);
			return "[ColorMatrixFilter]" + 
				"\n" + si + "[R] " + colorMatrix[0] + ", " + colorMatrix[1] + ", " + colorMatrix[2] + ", " + colorMatrix[3] + ", " + colorMatrix[4] +   
				"\n" + si + "[G] " + colorMatrix[5] + ", " + colorMatrix[6] + ", " + colorMatrix[7] + ", " + colorMatrix[8] + ", " + colorMatrix[9] + 
				"\n" + si + "[B] " + colorMatrix[10] + ", " + colorMatrix[11] + ", " + colorMatrix[12] + ", " + colorMatrix[13] + ", " + colorMatrix[14] + 
				"\n" + si + "[A] " + colorMatrix[15] + ", " + colorMatrix[16] + ", " + colorMatrix[17] + ", " + colorMatrix[18] + ", " + colorMatrix[19]; 
		}
	}
}
